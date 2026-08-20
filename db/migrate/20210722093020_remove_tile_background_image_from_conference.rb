class RemoveTileBackgroundImageFromConference < ActiveRecord::Migration[4.2]
  def change
    remove_column :conferences, :tile_background_file_name, :string
  end
end
