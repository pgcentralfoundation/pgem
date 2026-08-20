class AddStateToVenues < ActiveRecord::Migration[4.2]
  def change
    add_column :venues, :state, :string
  end
end
