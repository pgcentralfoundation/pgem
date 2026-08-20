class AddDescriptionToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :description, :text
  end
end
