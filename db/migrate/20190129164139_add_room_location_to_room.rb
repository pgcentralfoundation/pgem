class AddRoomLocationToRoom < ActiveRecord::Migration[4.2]
  def change
    add_column :rooms, :room_location_id, :integer
    add_foreign_key :rooms, :room_locations
  end
end
