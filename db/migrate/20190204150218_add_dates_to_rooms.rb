class AddDatesToRooms < ActiveRecord::Migration[4.2]
  def self.up
    add_column :rooms, :start_date, :date
    add_column :rooms, :end_date, :date
  end

  def self.down
    remove_column :rooms, :start_date
    remove_column :rooms, :end_date
  end
end
