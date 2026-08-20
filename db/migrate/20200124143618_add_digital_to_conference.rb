class AddDigitalToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :digital, :boolean
  end
end
