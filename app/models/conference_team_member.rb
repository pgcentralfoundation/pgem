class ConferenceTeamMember < ActiveRecord::Base
  belongs_to :conference
  belongs_to :team_member, class_name: 'Spina::TeamMember', foreign_key: :team_member_id

  acts_as_list scope: :conference
  default_scope { order(position: :asc) }

  delegate :fullname, to: :team_member
  delegate :photo, to: :team_member
  delegate :role, to: :team_member
  delegate :twitter, to: :team_member
  delegate :linkedin, to: :team_member
  delegate :description, to: :team_member

end
