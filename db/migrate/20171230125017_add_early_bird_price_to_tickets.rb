class AddEarlyBirdPriceToTickets < ActiveRecord::Migration[4.2]
  def self.up
    add_monetize :tickets, :early_bird_price
  end

  def self.down
    remove_monetize :tickets, :early_bird_price
  end
end
