class AddTicketToEvents < ActiveRecord::Migration[4.2]
  def change
    add_reference :events, :ticket

    add_index :events, [:ticket_id]

    add_foreign_key :events, :tickets

  end
end
