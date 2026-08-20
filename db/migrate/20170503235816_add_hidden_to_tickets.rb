class AddHiddenToTickets < ActiveRecord::Migration[4.2]
  def change
    add_column :tickets, :hidden, :boolean, default: false
  end
end
