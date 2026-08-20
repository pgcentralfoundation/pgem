class AddCurrencyToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :default_currency, :string, default: 'USD'
    add_column :conferences, :braintree_merchant_account, :string
  end
end
