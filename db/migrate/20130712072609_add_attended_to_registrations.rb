class AddAttendedToRegistrations < ActiveRecord::Migration[4.2]
  def change
    add_column :registrations, :attended, :boolean, default: false
  end
end
