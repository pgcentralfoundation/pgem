class AddBackgroundImageToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :background_file_name, :string
  end
end
