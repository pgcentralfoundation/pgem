class EventUser < ActiveRecord::Base
  # TODO Do we need these roles?
  ROLES = [['Speaker', 'speaker'], ['Submitter', 'submitter'], ['Moderator', 'moderator']]

  belongs_to :event
  belongs_to :user

  def self.set_is_highlight(program, user, is_highlight)
    program.event_users.where(user: user).update(is_highlight: is_highlight)
  end
end
