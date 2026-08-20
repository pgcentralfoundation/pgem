class AddItineraryReqToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :require_itinerary, :boolean
  end
end
