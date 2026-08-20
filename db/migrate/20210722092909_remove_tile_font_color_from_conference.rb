class RemoveTileFontColorFromConference < ActiveRecord::Migration[4.2]
  def change
    remove_column :conferences, :tile_font_color, :string
  end
end
