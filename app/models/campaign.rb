class Campaign < ActiveRecord::Base
  validates :name, :utm_campaign, presence: true

  has_many :targets, dependent: :nullify
  belongs_to :conference
  belongs_to :sponsor

  has_paper_trail ignore: [:updated_at], meta: { conference_id: :conference_id }

  before_create :set_start
  ##
  # Returns the utm parameters formatted as url.
  #
  # ====Returns
  # * +String+ -> url parameters e.g. ?utm_source=facebook
  def url_parameters
    kv = []
    get_parameters.each_pair do |k, v|
      kv += ["#{k}=#{v}"]
    end
    '?' + kv.join('&') unless kv.empty?
  end

  ##
  # Returns the counted visits generated by this campaign.
  #
  # ====Returns
  # * +Fixnum+ -> visits
  def visits_count
    Ahoy::Visit.where(get_parameters).where('started_at > ?', created_at).count
  end

  ##
  # Returns the counted registrations generated by this campaign.
  #
  # ====Returns
  # * +Fixnum+ -> visits
  def registrations_count
    events_by_name('Registered')
  end

  ##
  # Returns the counted event submissions generated by this campaign.
  #
  # ====Returns
  # * +Fixnum+ -> visits
  def submissions_count
    events_by_name('Event submission')
  end

  ##
  # Helper method to get the parameters for queries.
  #
  # ====Returns
  # * +Hash+ -> parameter => value
  def get_parameters
    conditions = {}
    conditions[:utm_source] = self[:utm_source] unless self[:utm_source].blank?
    conditions[:utm_medium] = self[:utm_medium] unless self[:utm_medium].blank?
    conditions[:utm_term] = self[:utm_term] unless self[:utm_term].blank?
    conditions[:utm_content] = self[:utm_content] unless self[:utm_content].blank?
    conditions[:utm_campaign] = self[:utm_campaign] unless self[:utm_campaign].blank?
    conditions
  end

  private

  ##
  # Helper method for submissions and registrations.
  #
  # ====Returns
  # * +Fixnum+ -> registrations / submissions
  def events_by_name(event_name)
    parameters = get_parameters
    parameters['ahoy_events.name'] = event_name
    Ahoy::Visit.joins(:ahoy_events).where(parameters).where('started_at > ?', created_at).count
  end

  def set_start
    self.started_at = Date.current
  end
end
