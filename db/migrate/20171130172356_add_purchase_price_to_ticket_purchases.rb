class AddPurchasePriceToTicketPurchases < ActiveRecord::Migration[4.2]
  def change
    add_monetize :ticket_purchases, :purchase_price
  end
end
