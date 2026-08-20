class AddTileImagesToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :tile_background_file_name, :string
  end
end
