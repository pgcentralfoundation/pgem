class ChangeLodgingAssociationToConference < ActiveRecord::Migration[4.2]
  # See 20140801164901_move_conference_media_to_commercial.rb for why this is needed.
  disable_ddl_transaction!

  class TempConference < ActiveRecord::Base
    self.table_name = 'conferences'
  end

  class TempVenue < ActiveRecord::Base
    self.table_name = 'venues'
  end

  class TempLodging < ActiveRecord::Base
    self.table_name = 'lodgings'
  end

  def change
    add_column :lodgings, :conference_id, :integer
    TempLodging.reset_column_information

    # Change association from venue and conference
    TempConference.all.each do |conference|
      if TempVenue.exists?(conference_id: conference.id)
        venue = TempVenue.find_by(conference_id: conference.id)
        lodgings = TempLodging.where(venue_id: venue.id)
        lodgings.each do |lodging|
	  lodging.update(conference_id: conference.id)
        end
      end
    end

    remove_column :lodgings, :venue_id, :integer
  end
end
