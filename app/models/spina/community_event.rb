module Spina
  class CommunityEvent < ApplicationRecord
    # FIXME: migrate to new name
    self.table_name = 'refinery_community_events'

    validates :title, presence: true, uniqueness: true

    # Scopes for cleaner filtering
    scope :newest_first, -> { order(published_at: :desc) }
    scope :recent, ->(count) { newest_first.limit(count) }

    def self.search(query)
      where("title ILIKE ?", "%#{query}%")
    end
  end
end