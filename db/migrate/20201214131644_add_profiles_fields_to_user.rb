class AddProfilesFieldsToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :country, :string
    add_column :users, :state, :string
    add_column :users, :city, :string
  end
end
