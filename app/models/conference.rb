##
# This class represents a conference
class Conference < ActiveRecord::Base
  require 'uri'
  serialize :events_per_week, Hash
  # Needed to call 'Conference.with_role' in /models/ability.rb
  # Dependent destroy will fail as roles#destroy will be cancelled,hence delete_all
  resourcify :roles, dependent: :delete_all

  default_scope { order('start_date DESC') }
  scope :without_archived, -> { where(deleted_at: nil) }
  has_paper_trail ignore: [:updated_at, :guid, :revision, :events_per_week], meta: { conference_id: :id }
  has_soft_deletion default_scope: false

  belongs_to :conference_group

  has_and_belongs_to_many :questions
  has_and_belongs_to_many :policies
  has_and_belongs_to_many :codes, :join_table => :conferences_codes

  has_one :splashpage, dependent: :destroy
  has_one :contact, dependent: :destroy
  has_one :registration_period, dependent: :destroy
  has_one :sponsorship_info, dependent: :destroy
  has_one :payment_method, dependent: :destroy
  has_one :email_settings, dependent: :destroy
  has_one :program, dependent: :destroy
  has_one :poll, dependent: :destroy
  has_one :venue, dependent: :destroy
  has_many :physical_tickets, through: :ticket_purchases
  has_many :sponsorship_levels_benefits, through: :sponsorship_levels
  has_many :ticket_purchases, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :supporters, through: :ticket_purchases, source: :user
  has_many :ticket_groups, -> { order('position ASC') }, dependent: :destroy
  has_many :ticket_group_benefits, through: :ticket_groups
  has_many :tickets, -> { order('position ASC') }, dependent: :destroy

  has_many :lodgings, dependent: :destroy
  has_many :activities, dependent: :destroy
  has_many :advantages, dependent: :destroy
  has_many :boomset_ticket_configs, dependent: :destroy
  has_many :integrations, dependent: :destroy
  has_many :registrations, dependent: :destroy
  has_many :participants, through: :registrations, source: :user
  has_many :vdays, dependent: :destroy
  has_many :vpositions, dependent: :destroy
  has_many :sponsorship_levels, -> { order('position ASC') }, dependent: :destroy
  has_many :sponsorships, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :campaigns, dependent: :destroy
  has_many :commercials, as: :commercialable, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :benefits, dependent: :destroy
  has_many :conference_team_members

  has_many :duplicate_tickets

  accepts_nested_attributes_for :venue
  accepts_nested_attributes_for :tickets, allow_destroy: true
  accepts_nested_attributes_for :sponsorship_levels, allow_destroy: true
  accepts_nested_attributes_for :sponsorships, allow_destroy: true
  accepts_nested_attributes_for :email_settings
  accepts_nested_attributes_for :questions, allow_destroy: true
  accepts_nested_attributes_for :policies, allow_destroy: true
  accepts_nested_attributes_for :codes, allow_destroy: true
  accepts_nested_attributes_for :vdays, allow_destroy: true
  accepts_nested_attributes_for :vpositions, allow_destroy: true
  accepts_nested_attributes_for :targets, allow_destroy: true
  accepts_nested_attributes_for :campaigns, allow_destroy: true

  mount_uploader :picture, PictureUploader, mount_on: :logo_file_name
  mount_uploader :background, BackgroundUploader, mount_on: :background_file_name

  validates_presence_of :title,
                        :short_title,
                        :start_date,
                        :end_date,
                        :start_hour,
                        :end_hour,
                        :ticket_layout,
                        :default_currency

  validates_uniqueness_of :short_title
  validates_format_of :short_title, with: /\A[a-zA-Z0-9_-]*\z/
  validates :registration_limit, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # This validation is needed since a conference with a start date greater than the end date is not possible
  validate :valid_date_range?
  validate :valid_times_range?
  validate :schedule_ok?, on: :update

  before_create :generate_guid
  before_create :add_color
  before_create :create_email_settings

  after_update :handle_timezone_change

  enum ticket_layout: [:portrait, :landscape]

  def date_range_string
    startstr = 'Unknown - '
    endstr = 'Unknown'
    if start_date.month == end_date.month && start_date.year == end_date.year
      startstr = start_date.strftime('%B %d - ')
      endstr = end_date.strftime('%d, %Y')
    elsif start_date.month != end_date.month && start_date.year == end_date.year
      startstr = start_date.strftime('%B %d - ')
      endstr = end_date.strftime('%B %d, %Y')
    else
      startstr = start_date.strftime('%B %d, %Y - ')
      endstr = end_date.strftime('%B %d, %Y')
    end

    result = startstr + endstr
    result
  end

  ##
  # Checks if the user is registered to the conference
  #
  # ====Args
  # * +user+ -> The user we check for
  # ====Returns
  # * +false+ -> If the user is registered
  # * +true+ - If the user isn't registered
  def user_registered? user
    user.present? && registrations.where(user_id: user.id).count > 0
  end

  ##
  # Checks if the registration for the conference is currently open
  #
  # ====Returns
  # * +false+ -> If the conference dates are not set or today isn't in the
  #   registration period.
  # * +true+ -> If today is in the registration period.
  def registration_open?
    registration_dates_given? &&
      (registration_period.start_date..registration_period.end_date).cover?(Date.current)
  end

  ##
  # Checks if the registration dates for the conference are provided
  #
  # ====Returns
  # * +false+ -> If the conference registration dates are not set
  # * +true+ -> If conference registration dates are set
  def registration_dates_given?
    registration_period.present? &&
      registration_period.start_date.present? &&
      registration_period.end_date.present?
  end

  ##
  # Checks if the Early Bird period is open
  #
  # ====Returns
  # * +false+ -> If today is less than early_bird_date
  # * +true+ -> If today is greater than early_bird_date
  def early_bird_open?
    registration_period.present? &&
      registration_open? &&
      registration_period.early_bird_date.present? &&
      Time.find_zone(timezone).today <= registration_period.early_bird_date
  end

  ##
  # Returns an array with the summarized event submissions per week.
  #
  # ====Returns
  #  * +Array+ -> e.g. [0, 3, 3, 5] -> first week 0 events, second week 3 events.
  def get_submissions_per_week
    result = []

    if program && program.cfp && program.events
      submissions = program.events.select(:week).group(:week).order(:week).count
      start_week = program.cfp.start_week
      weeks = program.cfp.weeks
      result = calculate_items_per_week(start_week, weeks, submissions)
    end
    result
  end

  ##
  # Returns an hash with submitted, confirmed and unconfirmed event submissions
  # per week.
  #
  # ====Returns
  #  * +Array+ -> e.g. 'Submitted' => [0, 3, 3, 5]  -> first week 0 events, second week 3 events.
  def get_submissions_data
    result = {}
    if program && program.cfp && program.events
      result = get_events_per_week_by_state

      start_week = program.cfp.start_week
      end_week = end_date.strftime('%W').to_i
      weeks = weeks(start_week, end_week)

      result.each do |state, values|
        if state == 'Submitted'
          result['Submitted'] = pad_array_left_kumulative(start_week, values)
        else
          result[state] = pad_array_left_not_kumulative(start_week, values)
        end
      end
      result['Weeks'] =  weeks > 0 ? (1..weeks).to_a : 0
    end
    result
  end

  ##
  # Returns an array with the summarized registrations per week.
  #
  # ====Returns
  #  * +Array+ -> e.g. [0, 3, 3, 5] -> first week 0, second week 3 registrations
  def get_registrations_per_week
    result = []

    if registrations &&
        registration_period &&
        registration_period.start_date &&
        registration_period.end_date

      reg = registrations.group(:week).order(:week).count
      start_week = get_registration_start_week
      weeks = registration_weeks
      result = calculate_items_per_week(start_week, weeks, reg)
    end
    result
  end

  ##
  # Calculates how many weeks the registration is.
  #
  # ====Returns
  # * +Integer+ -> start week
  def registration_weeks
    result = 0
    weeks = 0
    if registration_period &&
        registration_period.start_date &&
        registration_period.end_date
      weeks = Date.new(registration_period.start_date.year, 12, 31).
          strftime('%W').to_i

      result = get_registration_end_week - get_registration_start_week + 1
    end
    result < 0 ? result + weeks : result
  end

  ##
  # Calculates how many weeks call for papers is.
  #
  # ====Returns
  # * +Integer+ -> weeks
  def cfp_weeks
    if program
      program.cfp.weeks
    else
      0
    end
  end

  ##
  # Calculates the end week of the registration
  #
  # ====Returns
  # * +Integer+ -> start week
  def get_registration_start_week
    if registration_period
      registration_period.start_date.strftime('%W').to_i
    else
      -1
    end
  end

  ##
  # Calculates the start week of the registration
  #
  # ====Returns
  # * +Integer+ -> start week
  def get_registration_end_week
    if registration_period
      registration_period.end_date.strftime('%W').to_i
    else
      -1
    end
  end

  ##
  # Checks if the conference is pending.
  #
  # ====Returns
  # * +false+ -> If the conference start date is in the past.
  # * +true+ -> If the conference start date is in the future.
  def pending?
    start_date > Date.today
  end

  ##
  # Checks if the conference is pending.
  #
  # ====Returns
  # * +false+ -> If the conference end date is in the future.
  # * +true+ -> If the conference end date is in the past.
  def ended?
    end_date < Date.today
  end

  ##
  # Returns a hash with booleans with the required conference options.
  #
  # ====Returns
  # * +hash+ -> true -> filled / false -> missing
  def get_status
    result = {
      registration: registration_date_set?,
      cfp: cfp_set?,
      venue: venue_set?,
      rooms: rooms_set?,
      tracks: tracks_set?,
      event_types: event_types_set?,
      difficulty_levels: difficulty_levels_set?,
      splashpage: splashpage && splashpage.public?,
      payment_method: payment_method_set?,
      contact_email: contact_email_set?,
      tickets: tickets_set?
    }

    result.update(
      process: calculate_setup_progress(result),
      short_title: short_title
    ).with_indifferent_access
  end

  ##
  # Returns a hash with user => submissions ordered by submissions for all conferences
  #
  # ====Returns
  # * +hash+ -> user: submissions
  def self.get_top_submitter(limit = 5)
    submitter = EventUser.select(:user_id).where('event_role = ?', 'submitter').limit(limit).group(:user_id)
    counter = submitter.order('count_all desc').count(:all)
    calculate_user_submission_hash(submitter, counter)
  end

  ##
  # Returns a hash with user => submissions ordered by submissions
  #
  # ====Returns
  # * +hash+ -> user: submissions
  def get_top_submitter(limit = 5)
    submitter = EventUser.joins(:event).select(:user_id).
        where('event_role = ? and program_id = ?', 'submitter', Conference.find(id).program.id).
        limit(limit).group(:user_id)
    counter = submitter.order('count_all desc').count(:all)
    Conference.calculate_user_submission_hash(submitter, counter)
  end

  ##
  # Returns a hash with event state => {value: count of event states, color: color}.
  # The result is calculated over all conferences.
  #
  # ====Returns
  # * +hash+ -> hash
  def self.event_distribution
    calculate_event_distribution_hash(Event.select(:state).group(:state).count)
  end

  ##
  # Returns a hash with event state => {value: count of event states, color: color}
  #
  # ====Returns
  # * +hash+ -> hash
  def event_distribution
    Conference.calculate_event_distribution_hash(program.events.select(:state).group(:state).count)
  end

  ##
  # Returns a hash with scheduled vs unscheduled events
  # { "Scheduled" => { value: number of confirmed and scheduled events, color: color },
  #   "Unscheduled" => { value: number of confirmed and unscheduled events, color: color }
  #
  # ====Returns
  # * +hash+ -> hash
  def scheduled_event_distribution
    confirmed_events = program.events.where(state: 'confirmed')
    scheduled_count = program.selected_event_schedules.try(:count) || 0
    scheduled_value =  { 'value' => scheduled_count, 'color' => 'green' }
    unscheduled_value =  { 'value' => confirmed_events.count - scheduled_count, 'color' => 'red' }
    { 'Scheduled' => scheduled_value, 'Unscheduled' => unscheduled_value }
  end

  ##
  # Returns a hash with Registration attended vs. Registration not attended
  # { "Attended" => { value: number of registration attended, color: color },
  #   "Not attended" => { value: number of registration not attended, color: color }
  #
  # ====Returns
  # * +hash+ -> hash
  def registration_distribution
    reg = registrations.includes(:user)
    attended_value =  { 'value' => reg.where(attended: true).count, 'color' => 'magenta' }
    not_attended_value =  { 'value' => reg.where.not(attended: true).count, 'color' => 'blue' }
    { 'Attended' => attended_value, 'Not attended' => not_attended_value }
  end

  ##
  # Returns a hash with affiliation =>
  # {value: count of registration whose user has that affilation, color: color}
  # In case that the affiliation is blank, it groups them in None and
  # if the number of persons that have an affiliation are less than the 2% of
  # the total number of registered people, they are grouped in others.
  #
  # ====Returns
  # * +hash+ -> hash
  def affiliation_distribution
    counted_affiliations = registrations.joins(:user).group(:affiliation).count
    result = {}
    i=1
    others = 0
    none = 0
    counted_affiliations.each do |key, value|
      if value < 0.02 * registrations.length
        others += value
      elsif key.blank?
        none += value
      else
        result[key.capitalize] = { 'value' => value, 'color' => next_color(i) }
        i += 1
      end
    end
    if others > 0
      result['Others'] = { 'value' => others, 'color' => next_color(i) }
      i += 1
    end
    result['None'] = { 'value' => none, 'color' => next_color(i) } if none > 0
    result
  end

  ##
  # Returns a hash with user distribution => {value: count of user state, color: color}
  # active: signed in during the last 3 months
  # unconfirmed: registered but not confirmed
  # dead: not signed in during the last year
  #
  # ====Returns
  # * +hash+ -> hash
  def self.user_distribution
    active_user = User.where('last_sign_in_at > ?', Date.today - 3.months).count
    unconfirmed_user = User.where('confirmed_at IS NULL').count
    dead_user = User.where('last_sign_in_at < ?', Date.today - 1.year).count

    calculate_user_distribution_hash(active_user, unconfirmed_user, dead_user)
  end

  ##
  # Calculates the overall program minutes
  #
  # ====Returns
  # * +hash+ -> Fixnum minutes
  def current_program_minutes
    events_grouped = program.events.select(:event_type_id).group(:event_type_id)
    events_counted = events_grouped.count
    calculate_program_minutes(events_grouped, events_counted)
  end

  ##
  # Calculates the overall program hours
  #
  # ====Returns
  # * +Fixnum+ -> Fixnum hours. Example: 1.5 gets rounded to 2. 1.3 gets rounded 1.
  def current_program_hours
    (current_program_minutes / 60.to_f).round
  end

  ##
  # Calculates the overall program minutes since date
  #
  # ====Returns
  # * +hash+ -> Fixnum minutes
  def new_program_minutes(date)
    events_grouped = program.events.select(:event_type_id).where('created_at > ?', date).group(:event_type_id)
    events_counted = events_grouped.count
    calculate_program_minutes(events_grouped, events_counted)
  end

  ##
  # Calculates the overall program hours since date
  #
  # ====Returns
  # * +Fixnum+ -> Fixnum hours
  def new_program_hours(date)
    (new_program_minutes(date) / 60.to_f).round
  end

  ##
  # Calculates the difficulty level distribution from all events.
  #
  # ====Returns
  # * +hash+ -> difficulty level => {color, value}
  def difficulty_levels_distribution(state = nil)
    calculate_event_distribution(:difficulty_level_id, :difficulty_level, state)
  end

  ##
  # Calculates the event_type distribution from all events.
  #
  # ====Returns
  # * +hash+ -> event_type => {color, value}
  def event_type_distribution(state = nil)
    calculate_event_distribution(:event_type_id, :event_type, state)
  end

  ##
  # Calculates the track distribution from all events.
  #
  # ====Returns
  # * +hash+ -> track => {color, value}
  def tracks_distribution(state = nil)
    if state
      tracks_grouped = program.events.select(:track_id).where('state = ?', state).group(:track_id)
    else
      tracks_grouped = program.events.select(:track_id).group(:track_id)
    end
    tracks_counted = tracks_grouped.count

    calculate_track_distribution_hash(tracks_grouped, tracks_counted)
  end

  ##
  # Return all pending conferences. If there are no pending conferences, the last two
  # past conferences are returned
  #
  # ====Returns
  # * +ActiveRecord+
  def self.get_active_conferences_for_dashboard
    result = Conference.without_archived.where('start_date > ?', Time.now).
        select('id, short_title, color, start_date, deleted_at')

    if result.length == 0
      result = Conference.
          select('id, short_title, color, start_date, deleted_at').limit(2).
          order(start_date: :desc)
    end
    result
  end

  ##
  # Return all conferences minus the active conferences
  #
  # ====Returns
  # * +ActiveRecord+
  def self.get_conferences_without_active_for_dashboard(active_conferences)
    result = Conference.without_archived.select('id, short_title, color, start_date, deleted_at').order(start_date: :desc)
    result - active_conferences
  end

  ##
  # A list with the three event states submitted, confirmed, unconfirmed with corresponding colors
  #
  # ====Returns
  # * +List+
  def self.get_event_state_line_colors
    [
      { short_title: 'Submitted', color: 'blue' },
      { short_title: 'Confirmed', color: 'green' },
      { short_title: 'Unconfirmed', color: 'orange' }
    ]
  end

  ##
  # A map with all conference targets with progress in percent of a certain unit.
  #
  # ====Returns
  # * +Map+ -> target => progress
  def get_targets(target_unit)
    conference_target = targets.where('unit = ?', target_unit)
    result = {}
    conference_target.each do |target|
      result[target.to_s] = target.get_progress
    end
    result
  end

  ##
  # A map with all conference campaigns associated with targets.
  #
  # ====Returns
  # * +Map+ -> campaign => {actual, target, progress}
  def get_campaigns
    result = {}
    campaigns.each do |campaign|
      campaign.targets.each do |target|
        result["#{target} from #{campaign.name}"] = target.get_campaign
      end
    end
    result
  end

  ##
  # Writes an snapshot of the actual event distribution to the database
  # Triggered each every Sunday 11:55 pm form whenever (config/schedule.rb).
  #
  def self.write_event_distribution_to_db
    week = DateTime.now.end_of_week

    Conference.where('end_date > ?', Date.today).each do |conference|
      result = {}
      Event.state_machine.states.each do |state|
        count = conference.program.events.where('state = ?', state.name).count
        result[state.name] = count
      end

      unless conference.events_per_week
        conference.events_per_week = {}
      end

      # Write to database
      conference.events_per_week[week] = result
      conference.save!
    end
  end

  ##
  # Checks if conference is updated for email notifications.
  #
  # ====Returns
  # * +True+ -> If conference is updated and all other parameters are set
  # * +False+ -> Either conference is not updated or one or more parameter is not set
  def notify_on_dates_changed?
    return false unless self.email_settings.send_on_conference_dates_updated
    # do not notify unless one of the dates changed
    return false unless self.start_date_changed? || self.end_date_changed?
    # do not notify unless the mail content is set up
    (!email_settings.conference_dates_updated_subject.blank? && !email_settings.conference_dates_updated_body.blank?)
  end

  ##
  # Checks if registration dates are updated for email notifications.
  #
  # ====Returns
  # * +True+ -> If registration dates is updated and all other parameters are set
  # * +False+ -> Either registration date is not updated or one or more parameter is not set
  def notify_on_registration_dates_changed?
    return false unless self.email_settings.send_on_conference_registration_dates_updated
    # do not notify unless we allow a registration
    return false unless self.registration_period
    # do not notify unless one of the dates changed
    return false unless registration_period.start_date_changed? || registration_period.end_date_changed?
    # do not notify unless the mail content is set up
    (!email_settings.conference_registration_dates_updated_subject.blank? && !email_settings.conference_registration_dates_updated_body.blank?)
  end

  def registration_limit_exceeded?
    registration_limit > 0 && registrations.count >= registration_limit
  end

  def tickets_sold_out?
    return false if registration_limit == 0
    ticket_purchases.sum(:quantity) >= registration_limit
  end

  # Returns an hexadecimal color given a collection. The returned color changed
  # when the number of element in the collection changes and for consecutive
  # number of elements it returns highly different colors.
  def next_color_for_collection(collection)
    # we have different start indices for every collection to generate a
    # different color for every of them.
    start_index = {
      tracks: (program.tracks.count + 1),
      levels: (program.difficulty_levels.count + 51),
      types: (program.event_types.count + 101)
    }
    next_color(start_index[collection])
  end

  # Returns the current day if it is a day of the schedule or nil otherwise
  def current_conference_day
    day = Time.find_zone(timezone).today
    day if (start_date..end_date).cover? day
  end

  # Returns the number of hours since the conference start hour (9) to the
  # current hour, in case that the current hour is beetween the start and the
  # end hour (20). Otherwise, returns 0
  def hours_from_start_time(start_hour, end_hour)
    current_time = Time.find_zone(timezone).now
    current_hour = current_time.strftime('%H').to_i
    (start_hour..(end_hour-1)).cover?(current_hour) ? current_hour - start_hour : 0
  end

  ##
  # Checks if the code is valid for the conference
  #
  # ====Args
  # * +applied_code+ -> The code we check for
  # ====Returns
  # * +code+ -> the code
  def get_valid_code(applied_code)
    codes.where(name: applied_code).first
  end

  def available_currency_codes
    currencies = []
    Money::Currency.table.values.each do |currency|
      currencies = currencies + [[currency[:name] + ' (' + currency[:iso_code] + ')', currency[:iso_code]]]
    end
    currencies
  end

  def highlighted_speakers
    User.joins(:event_users => :event)
        .where(:event_users => {is_highlight: true}, :events => {program_id: program.id})
        .distinct
  end

  def previous_conferences
    Conference.where("conference_group_id = ? AND start_date < ?", conference_group_id, start_date).order('start_date')
  end

  private

  # Returns a different html colour for every i and consecutive colors are
  # clearly different.
  def next_color(i)
    '#' + next_color_component(:r, i) + next_color_component(:g, i) + next_color_component(:b, i)
  end

  # Auxiliar function which is used in next_color and returns each component of
  # the color. We make use of big prime numbers to avoid repetition and to make
  # consecutive colors clearly different.
  def next_color_component(component, i)
    big_prime_numbers = {r: 113, g: 67, b: 151}
    ((i*big_prime_numbers[component])%239 + 16).to_s(16)
  end

  after_create do
    self.create_contact
    self.create_program
    create_roles
  end

  ##
  # Creates the roles of the conference
  # after the conference has been successfully created
  # Will create 4 new records for roles
  def create_roles
    Role.where(name: 'organizer', resource: self).first_or_create(description: 'For the organizers of the conference (who shall have full access)')
    Role.where(name: 'cfp', resource: self).first_or_create(description: 'For the members of the CfP team')
    Role.where(name: 'info_desk', resource: self).first_or_create(description: 'For the members of the Info Desk team')
    Role.where(name: 'volunteers_coordinator', resource: self).first_or_create(description: 'For the people in charge of volunteers')
  end

  ##
  # Checks if start date of the conference is greater than the end date
  #
  # Reports an error when such a condition is found
  def valid_date_range?
    errors.add(:start_date, 'Start date is greater than End date') if start_date && end_date && start_date > end_date
  end

  ##
  # Checks if start hour of the conference is greater or equal than the end hour
  # and that both hours are beetween 0 and 24
  #
  # Reports an error when such a condition is found
  def valid_times_range?
    if start_hour && end_hour
      errors.add(:start_hour, 'is lower than 0') if start_hour < 0
      errors.add(:end_hour, 'is lower or equal than start hour') if end_hour <= start_hour
      errors.add(:end_hour, 'is greater than 24') if end_hour > 24
    end
  end

  ##
  # Calculates the weeks from a start and a end week.
  #
  # ====Returns
  # * +Fixnum+ -> weeks
  def weeks(start_week, end_week)
    weeks = end_week - start_week + 1
    weeks_of_year = Date.new(start_date.year, 12, 31).strftime('%W').to_i
    weeks < 0 ? weeks + weeks_of_year : weeks
  end

  ##
  # Returns a Hash with the events with the state confirmend / unconfirmed per week.
  #
  # ====Returns
  # * +Hash+ -> e.g. 'Confirmed' => { 3 => 5, 4 => 6 }
  def get_events_per_week_by_state
    result = {
      'Submitted' => {},
      'Confirmed' => {},
      'Unconfirmed' => {}
    }

    # Completed weeks
    events_per_week.each do |week, values|
      values.each do |state, value|
        if [:confirmed, :unconfirmed].include?(state)
          unless result[state.to_s.capitalize]
            result[state.to_s.capitalize] = {}
          end
          result[state.to_s.capitalize][week.strftime('%W').to_i] = value
        end
      end
    end

    # Actual week
    this_week = Date.today.end_of_week.strftime('%W').to_i
    result['Confirmed'][this_week] = program.events.where('state = ?', :confirmed).count
    result['Unconfirmed'][this_week] = program.events.where('state = ?', :unconfirmed).count
    result['Submitted'] = program.events.select(:week).group(:week).count
    result['Submitted'][this_week] = program.events.where(week: this_week).count
    result
  end

  ##
  # Returns an array from the hash values with left padding.
  #
  # ====Returns
  # * +Array+ -> [0, 0, 1, 2, 3, 0, 0]
  def pad_array_left_not_kumulative(start_week, hash)
    hash = assert_keys_are_continuously(hash)

    first_week = hash.keys[0]
    left = pad_left(first_week, start_week)
    left + hash.values
  end

  ##
  # Returns an array from the hash values with left padding.
  #
  # ====Returns
  # * +Array+ -> [0, 0, 1, 2, 3, 3, 3]
  def pad_array_left_kumulative(start_week, hash)
    hash = assert_keys_are_continuously(hash)
    result = cumulative_sum(hash.values)

    first_week = hash.keys[0]
    left = pad_left(first_week, start_week)
    left + result
  end

  ##
  # Cumulative sums an array.
  #
  # ====Returns
  # * +Array+ -> [1, 2, 3, 4] --> [1, 3, 7, 11]
  def cumulative_sum(array)
    sum = 0
    array.map { |x| sum += x }
  end

  ##
  # Returns the left padding.
  #
  # ====Returns
  # * +Array+
  def pad_left(first_week, start_week)
    left = []
    if first_week > start_week
      left = Array.new(first_week - start_week - 1, 0)
    end
    left
  end

  ##
  # Asserts that all keys in the hash are continuously.
  # If not, the missing key is inserted with value 0.
  #
  # ====Returns
  # * +Hash+  { 1 => 1, 2 => 0, 3 => 0, 4 => 3 }
  def assert_keys_are_continuously(hash)
    keys = hash.keys
    (keys.min..keys.max).each do |key|
      unless hash[key]
        hash[key] = 0
      end
    end
    Hash[ hash.sort ]
  end

  ##
  # Returns the progress of the set up conference list in percent
  #
  # ====Returns
  # * +String+ -> Progress in Percent
  def calculate_setup_progress(result)
    (100 * result.values.count(true) / result.values.count).to_s
  end

  ##
  # Checks if there is a difficulty level.
  #
  # ====Returns
  # * +True+ -> One difficulty level or more
  # * +False+ -> No diffculty level
  def difficulty_levels_set?
    program.difficulty_levels.count > 0
  end

  ##
  # Checks if there is a difficulty level.
  #
  # ====Returns
  # * +True+ -> One difficulty level or more
  # * +False+ -> No diffculty level
  def event_types_set?
    program.event_types.count > 0
  end

  ##
  # Checks if there is a payment method set.
  #
  # ====Returns
  # * +True+ -> Payment method is set
  # * +False+ -> No payment method
  def payment_method_set?
    payment_method.present?
  end

  ##
  # Checks if the conference has a valid contact email to be used for outbound emails
  #
  # ====Returns
  # * +True+ -> Email is set
  # * +False+ -> No email
  def contact_email_set?
    contact.email.present?
  end

  ##
  # Checks if there is a track.
  #
  # ====Returns
  # * +True+ -> One track or more
  # * +False+ -> No track
  def tracks_set?
    program.tracks.count > 0
  end

  ##
  # Checks if there is a ticket.
  #
  # ====Returns
  # * +True+ -> One ticket or more
  # * +False+ -> No tickets
  def tickets_set?
    tickets.count > 0
  end

  ##
  # Checks if there is a room.
  #
  # ====Returns
  # * +True+ -> One room or more
  # * +False+ -> No room
  def rooms_set?
    venue.present? && venue.rooms.count > 0
  end

  # Checks if the conference has a venue object.
  #
  # ====Returns
  # * +True+ -> If conference has a venue object.
  # * +False+ -> IF conference has no venue object.
  def venue_set?
    !!venue
  end

  ##
  # Checks if the conference has a call for papers object.
  #
  # ====Returns
  # * +True+ -> If conference has a cfp object.
  # * +False+ -> If conference has no cfp object.
  def cfp_set?
    !!program.cfp
  end

  ##
  # Checks if conference has a start and a end date.
  #
  # ====Returns
  # * +True+ -> If conference has a start and a end date.
  # * +False+ -> If conference has no start or end date.
  def registration_date_set?
    !!registration_period && !!registration_period.start_date && !!registration_period.end_date
  end

  # Calculates the distribution from events.
  #
  # ====Returns
  # * +hash+ -> object_type => {color, value}
  def calculate_event_distribution(group_by_id, association_symbol, state = nil)
    if state
      grouped = program.events.select(group_by_id).where('state = ?', 'confirmed').group(group_by_id)
    else
      grouped = program.events.select(group_by_id).group(group_by_id)
    end
    counted = grouped.count

    calculate_distribution_hash(grouped, counted, association_symbol)
  end

  ##
  # Helper method to calculate the correct data format for the doughnut charts.
  #
  # ====Returns
  # * +hash+ -> object_type => {color, value}
  def calculate_distribution_hash(grouped, counter, symbol)
    result = {}

    grouped.each do |event|
      object = event.send(symbol)
      if object
        result[object.title] = {
          'value' => counter[object.id],
          'color' => object.color
        }
      end
    end
    result
  end

  ##
  # Helper method to calculate the correct data format for the doughnut charts
  # for track distribution of events.
  #
  # ====Returns
  # * +hash+ -> object_type => {color, value}
  def calculate_track_distribution_hash(tracks_grouped, tracks_counter)
    result = {}
    tracks_grouped.each do |event|
      if event.track
        result[event.track.name] = {
          'value' => tracks_counter[event.track_id],
          'color' => event.track.color
        }
      end
    end
    result
  end

  ##
  # Helper method to calculate the program minutes.
  #
  # ====Returns
  # * +Fixnums+ summed program minutes
  def calculate_program_minutes(events_grouped, events_counted)
    result = 0
    events_grouped.each do |event|
      result += events_counted[event.event_type_id] * event.event_type.length
    end
    result
  end

  ##
  # Helper method for calculating hash with corresponding colors of user distribution states.
  #
  # ====Returns
  # * +hash+ -> hash
  def self.calculate_user_distribution_hash(active_user, unconfirmed_user, dead_user)
    result = {}
    if active_user > 0
      result['Active'] = {
        'color' => 'green',
        'value' => active_user
      }
    end
    if unconfirmed_user > 0
      result['Unconfirmed'] = {
        'color' => 'red',
        'value' => unconfirmed_user
      }
    end
    if dead_user > 0
      result['Dead'] = {
        'color' => 'black',
        'value' => dead_user
      }
    end
    result
  end

  ##
  # Helper method. Calculates hash with corresponding colors of event state distribution.
  #
  # ====Returns
  # * +hash+ -> hash
  def self.calculate_event_distribution_hash(states)
    result = {}
    states.each do |key, value|
      result[key.capitalize] =
          {
            'value' => value,
            'color' => Event.get_state_color(key)
          }
    end
    result
  end

  ##
  # Returns a hash with user => submissions ordered by submissions for all conferences
  #
  # ====Returns
  # * +hash+ -> user: submissions
  def self.calculate_user_submission_hash(submitters, counter)
    result = ActiveSupport::OrderedHash.new
    counter.each do |key, value|
      # make PG happy by including the user_id in ORDER
      submitter = submitters.where(user_id: key).order(:user_id).first
      if submitter
        result[submitter.user] = value
      end
    end
    result
  end

  ##
  # Creates a EmailSettings association proxy. Used as before_create.
  #
  EMAIL_SETTINGS_DEFAULTS = {
    purchase_confirmation_subject: "{conference} - Purchase Confirmation",
    purchase_confirmation_body: "Dear {name},

Thanks! You have successfully purchased tickets for the event {conference}. Your payment id is {payment_id}.

Please, find the receipt attached.

{ticket_extra}

Best wishes

{conference} Team",
    ticket_confirmation_subject: "{conference} - Ticket Confirmation and PDF!",
    ticket_confirmation_body: "Dear {name},

Thanks!  You have successfully booked {ticket_quantity} {ticket_title} ticket(s) for the event {conference}. Your transaction id is {ticket_purchase_id}.

Please, find the ticket(s) pdf attached.

{ticket_extra}

Best wishes

{conference} Team",
    assign_ticket_subject: "{conference} - Ticket Assignment",
    assign_ticket_body: "Hello {name},

{assigner_name} has booked {ticket_title} ticket for the event {conference} and assigned it to your account.

Please, find the ticket attached.

{ticket_extra}

Best wishes

{conference} Team",
    pending_assign_ticket_subject: "{conference} - Ticket Assignment",
    pending_assign_ticket_body: "Hello,

{assigner_name} has booked a {ticket_title} ticket for the event {conference} and is attempting to assign it to you. To claim the ticket, you must complete your registration at the link below.

{ticket_claim_link}

{ticket_extra}

Best wishes

{conference} Team"
  }


  def create_email_settings
    build_email_settings(EMAIL_SETTINGS_DEFAULTS)
    true
  end

  ##
  # Creates a UID for the conference. Used as before_create.
  #
  def generate_guid
    guid = SecureRandom.urlsafe_base64
#     begin
#       guid = SecureRandom.urlsafe_base64
#     end while User.where(:guid => guid).exists?
    self.guid = guid
  end

  ##
  # Adds a random color to the conference
  #
  def add_color
    unless color
      self.color = get_color
    end
  end

  def get_color
    %w(
      #000000 #ffffff #d32f2f #c2185b #7b1fa2 #512da8
      #303f9f #1976d2 #0288d1 #0097a7 #00796b #388e3c
      #689f38 #afb42b #fbc02d #ffa000 #f57c00 #e64a19
      #5d4037 #616161 #455a64
      ).sample
  end

  # Calculates items per week from a hash.
  #
  # ====Returns
  #  * +Array+ -> e.g. [1, 3, 3, 5] -> first week 1, second week 2 registrations
  def calculate_items_per_week(start_week, weeks, items)
    sum = 0
    result = []
    last_key = start_week - 1

    if !items.empty? && start_week > items.keys[0].to_i
      start_week = items.keys[0].to_i
      weeks += start_week - items.keys[0].to_i + 1
    end

    items.each do |key, value|
      # Padding
      if last_key < (key.to_i - 1)
        result += Array.new(key.to_i - last_key - 1, sum)
      end

      sum += value
      result.push(sum)
      last_key = key.to_i
    end

    # Padding right
    if result.length < weeks
      result += Array.new(weeks - result.length, sum)
    end

    result
  end

  def handle_timezone_change
    # unschedule events if conference timezone changed
    if self.timezone_changed?
      tzchanges = self.changes[:timezone]
      tz_old = ActiveSupport::TimeZone.new(tzchanges[0])
      tz_new = ActiveSupport::TimeZone.new(tzchanges[1])
      tzdiff = tz_old.utc_offset - tz_new.utc_offset
      if tzdiff != 0
        program.selected_schedule.event_schedules.destroy_all if program.selected_schedule
      end
    end
  end

  ##
  # Verifies that there are no event_schedules beyound the new conference date/time range
  #
  # Reports a list of orphans if found
  def schedule_ok?
    if self.start_date_changed? || self.end_date_changed? || self.start_hour_changed? || self.end_hour_changed?
      if program.selected_schedule
        sched_start = DateTime.parse("#{self.start_date.to_s} #{self.start_hour}")
        sched_end = DateTime.parse("#{self.end_date.to_s} #{self.end_hour}")
        bad_schedules = []
        program.selected_schedule.event_schedules.each do |es|
          fits = es.start_time >= sched_start && es.end_time <= sched_end
          bad_schedules.push(es.event.title) unless fits
        end
        if bad_schedules.present?
          errors.add(:base, 'The following events will end up beyound of new conference start/end time boundaries, please unschedule them first: ')
          errors.add(:base, bad_schedules.join(', '))
        end
      end
    end
  end

end
