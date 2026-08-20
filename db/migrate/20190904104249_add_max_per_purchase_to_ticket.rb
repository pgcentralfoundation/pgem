class AddMaxPerPurchaseToTicket < ActiveRecord::Migration[4.2]
  def change
    add_column :tickets, :max_per_purchase, :integer, default: 10
  end
end
