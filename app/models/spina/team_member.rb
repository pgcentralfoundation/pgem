module Spina
  class TeamMember < ApplicationRecord
    belongs_to :photo, optional: true, class_name: 'Spina::Image'
    has_many :conference_team_members, foreign_key: :team_member_id, dependent: :destroy

    validates :firstname, presence: true
    validate :description_limit

    scope :sorted, -> { order(:position) }

    before_create :set_default_position

    def fullname
      [firstname, middlename, lastname].reject(&:blank?).join(' ')
    end

    def to_s
      fullname
    end

    private

    def set_default_position
      self.position ||= self.class.maximum(:position).to_i.next
    end

    def description_limit
      return if description.blank?

      errors.add(:description, 'is limited to 50 words.') if description.split.length > 50
    end
  end
end
