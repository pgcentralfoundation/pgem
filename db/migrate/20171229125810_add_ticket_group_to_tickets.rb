class AddTicketGroupToTickets < ActiveRecord::Migration[4.2]
  def self.up
    add_reference :tickets, :ticket_group, index: true, foreign_key: true
  end

  def self.down
    remove_foreign_key :tickets, :ticket_groups
    remove_reference :tickets, :ticket_group, index: true
  end
end
