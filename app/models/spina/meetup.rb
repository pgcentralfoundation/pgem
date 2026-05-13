module Spina
  class Meetup < ApplicationRecord
    # FIXME: migrate to new name
    self.table_name = 'refinery_meetups' 

    validates :url, presence: true, uniqueness: true

    scope :earliest, -> { where('start > ?', DateTime.now) }
    scope :upcoming, ->(count) { earliest.order(start: :asc).limit(count) }

    def self.search(query)
      where("title ILIKE ?", "%#{query}%")
    end
  end
end