class AddPendingEventTicketsToTicketPurchases < ActiveRecord::Migration[4.2]
  def change
    add_column :ticket_purchases, :pending_event_tickets, :string
  end
end
