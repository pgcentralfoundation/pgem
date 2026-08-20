class ChangeConferenceIdToVenueIdInRooms < ActiveRecord::Migration[4.2]
  # See 20140801164901_move_conference_media_to_commercial.rb for why this is needed.
  disable_ddl_transaction!

  class TempConference < ActiveRecord::Base
    self.table_name = 'conferences'

    has_one :temp_venue
  end

  class TempVenue < ActiveRecord::Base
    self.table_name = 'venues'

    belongs_to :temp_conference, optional: true
    has_many :temp_rooms
  end

  class TempRoom < ActiveRecord::Base
    self.table_name = 'rooms'

    belongs_to :temp_venue, optional: true
  end

  def up
    add_column :rooms, :venue_id, :integer

    TempRoom.all.each do |room|
      venue = TempVenue.find_by(conference_id: room.conference_id)
      if venue
        room.venue_id = venue.id
      else
        test_venue = Venue.find_or_create_by!(conference_id: room.conference_id, name: 'test venue', street: 'test street', city: 'test city', country: 'test')
        room.venue_id = test_venue.id
      end
      room.save!
    end

    change_column :rooms, :venue_id, :integer, null: false
    remove_column :rooms, :conference_id
  end

  def down
    add_column :rooms, :conference_id, :integer

    TempRoom.all.each do |room|
      venue = TempVenue.find(room.venue_id)
      conference = TempConference.find(venue.conference_id)

      if conference
        room.conference_id = conference.id
      end

      room.save!
    end

    change_column :rooms, :conference_id, :integer, null: false
    remove_column :rooms, :venue_id
  end
end
