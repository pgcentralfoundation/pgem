class IChainRecordNotFound < StandardError
end

class UserDisabled < StandardError
end

class User < ActiveRecord::Base
  rolify
  has_many :physical_tickets, through: :ticket_purchases do
    def by_conference(conference)
      where('ticket_purchases.conference_id = ?', conference)
    end
  end
  has_many :users_roles
  has_many :roles, through: :users_roles, dependent: :destroy

  has_paper_trail on: [:create, :update], ignore: [:sign_in_count, :remember_created_at, :current_sign_in_at, :last_sign_in_at, :current_sign_in_ip, :last_sign_in_ip, :unconfirmed_email,
                                                   :avatar_content_type, :avatar_file_size, :avatar_updated_at, :updated_at, :confirmation_sent_at, :confirmation_token, :reset_password_token]

  include Gravtastic
  gravtastic size: 32

  mount_uploader :avatar, AvatarUploader, mount_on: :avatar_file_name

  before_create :setup_role
  after_update :check_active_integrations

  # add scope
  scope :comment_notifiable, ->(conference) {joins(:roles).where('roles.name IN (?)', [:organizer, :cfp]).where('roles.resource_type = ? AND roles.resource_id = ?', 'Conference', conference.id)}

  extend FriendlyId
  friendly_id :name, use: [:slugged, :history, :finders]

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise_modules = []

  if ENV['OSEM_ICHAIN_ENABLED'] == 'true'
    devise_modules += [ :ichain_authenticatable, :ichain_registerable, :omniauthable, omniauth_providers: [] ]
  else
    devise_modules += [:database_authenticatable, :registerable, :magic_link_authenticatable,
                       :recoverable, :rememberable, :trackable, :validatable, :confirmable,
                       ]
  end

  devise(*devise_modules)

  has_many :openids

  attr_accessor :login

  has_many :event_users, dependent: :destroy
  has_many :events, -> { uniq }, through: :event_users
  has_many :presented_events, -> { joins(:event_users).where(event_users: {event_role: 'speaker'}).uniq }, through: :event_users, source: :event
  has_many :registrations, dependent: :destroy
  has_many :events_registrations, through: :registrations
  has_many :ticket_purchases, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :tickets, through: :ticket_purchases, source: :ticket
  has_many :votes, dependent: :destroy
  has_many :voted_events, through: :votes, source: :events
  has_many :subscriptions, dependent: :destroy
  accepts_nested_attributes_for :roles

  has_one :sponsors_user, dependent: :destroy
  has_one :sponsor, through: :sponsors_user

  scope :admin, -> { where(is_admin: true) }
  scope :speakers_only, -> { joins(:event_users).where("event_users.event_role in ('submitter', 'speaker')").uniq }
  validates :email, presence: true

  validate :biography_limit

  ##
  # Checkes if the user attended the event
  # This is used for events that require registration
  # The user must have registered to attend the event
  # Gets an event
  # === Returns
  # * +true+ if the user attended the event
  # * +false+ if the user did not attend the event
  def attended_event? event
    event_registration = event.events_registrations.find_by(registration: self.registrations)

    return false unless event_registration.present?
    event_registration.attended
  end

  def name
    self[:name].blank? ? first_name.to_s + " " + last_name.to_s : self[:name]
  end

  ##
  # Checks if a user has registered to an event
  # ====Returns
  # * +true+ or +false+
  def registered_to_event? event
    event.registrations.pluck(:id).include? self.registrations.find_by(conference_id: event.program.conference.id).id
  end

  def subscribed? conference
    self.subscriptions.find_by(conference_id: conference.id).present?
  end

  def supports? conference
    ticket_purchases.find_by(conference_id: conference.id).present?
  end

  def is_speaker? conference
    self.presented_events.where(state: 'confirmed').joins(:program).where('programs.conference_id = ?', conference.id).present?
  end

  def is_sponsor? conference
    TicketPurchase.where(conference_id: conference.id).joins(:physical_tickets).where('physical_tickets.user_id = ?', self.id).joins(:code).where('codes.code_type_id = 2 AND codes.sponsor_id IS NOT NULL').present?
  end

  def is_highlight? conference
    self.presented_events.where(state: 'confirmed').joins(:program).where('programs.conference_id = ? and event_users.is_highlight = true', conference.id).present?
  end

  def self.for_ichain_username(username, attributes)
    user = find_by(username: username)

    raise UserDisabled if user && user.is_disabled

    if user
      user.update_attributes(email: attributes[:email],
                             last_sign_in_at: user.current_sign_in_at,
                             current_sign_in_at: Time.current)
    else
      begin
        user = create!(username: username, email: attributes[:email])
      rescue ActiveRecord::RecordNotUnique
        raise IChainRecordNotFound
      end
    end
    user
  end

  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    login = conditions.delete(:login)
    if login
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    else
      where(conditions).first
    end
  end

  # Searches for user based on email. Returns found user or new user.
  # ====Returns
  # * +User::ActiveRecord_Relation+ -> user
  def self.find_for_auth(auth, current_user = nil)
    user = current_user

    if user.nil? # No current user available, user is not already logged in
      user = User.where(email: auth.info.email).first_or_initialize
    end

    if user.new_record?
      user.email = auth.info.email
      user.name = auth.info.name
      user.username = auth.info.username
      user.password = Devise.friendly_token[0, 20]
      user.skip_confirmation!
    end

    user
  end

  # Gets the roles of the user, groups them by role.name and returns the resource(s) of each role
  # ====Returns
  # * +Hash+ * ->  e.g. 'organizer' =>  [conf1, conf2]
  def get_roles
    result = {}
    roles.each do |role|
      resource = Conference.find(role.resource_id).short_title
      if result[role.name].nil?
        result[role.name] = [resource]
      else
        result[role.name] << resource
      end
    end
    result
  end

  def registered
    registrations = self.registrations
    if registrations.count == 0
      'None'
    else
      registrations.map { |r| r.conference.title }.join ', '
    end
  end

  def attended
    registrations_attended = registrations.where(attended: true)
    if registrations_attended.count == 0
      'None'
    else
      registrations_attended.map { |r| r.conference.title }.join ', '
    end
  end

  def confirmed?
    !confirmed_at.nil?
  end

  def proposals(conference=nil)
    if conference
      events.where('program_id = ? AND event_users.event_role=?', conference.program.id, 'submitter')
    else
      events.where('event_users.event_role=?', 'submitter')
    end
  end

  def participated_events(conference=nil)
    if conference
      events.where('program_id = ? AND event_users.event_role=?', conference.program.id, 'speaker')
    else
      events.where('event_users.event_role=?', 'speaker')
    end
  end

  def proposal_count(conference)
    proposals(conference).count
  end

  # Django passwords encryption support
  def valid_password?(pwd)
    begin
      super(pwd) # try the standard way
    rescue
      Pbkdf2PasswordHasher.check_password(pwd,self.encrypted_password) # if failed, then try the django's way
    end
  end

  def avatar_url(options={})
    version = options[:version] || 'medium'
    if self.avatar?
      self.avatar.send version
    else
      size_map = {'large' => 200, 'medium' => 48, 'small' => 32, 'xsmall' => 25}
      gravatar_url(size: size_map[version])
    end
  end


  def active_plugins
    Refinery::Plugins.registered
    # @active_plugins ||= Refinery::Plugins.new(
    #   Refinery::Plugins.registered.select do |plugin|
    #     has_role?(:admin)
    #   end
    # )
  end

  def has_plugin?(name)
    active_plugins.names.include?(name)
  end

  def landing_url
    active_plugins.in_menu.first_url_in_menu
  end

  def sign_in_country
    ip = self.last_sign_in_ip || self.current_sign_in_ip
    Geocoder.search(ip).first.try(:country_code)
  end

  private

  def setup_role
    if User.count == 1 && User.first.email == 'deleted@localhost.osem'
      self.is_admin = true
    end
  end

  ##
  # Check if biography has an allowed number of words. Used as validation.
  #
  def biography_limit
    if self.biography.present?
      errors.add(:biography, 'is limited to 150 words.') if self.biography.split.length > 350
    end
  end

  ##
  # Check if any active conferences have integrations that require us to send
  # and update about the user change
  ##
  def check_active_integrations
    integrations = Integration.joins(:conference).where('conferences.end_date >= CURRENT_DATE')
    integrations.each do |integration|
      if integration.integration_type == "boomset"
        r = Registration.where(conference_id: integration.conference_id, user_id: self.id).first
	      BoomsetAttendeeRegisterJob.perform_later(r)
      end
    end
  end
end
