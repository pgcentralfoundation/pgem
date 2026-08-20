class AddPositionToTickets < ActiveRecord::Migration[4.2]
  def change
    add_column :tickets, :position, :integer
  end
end
