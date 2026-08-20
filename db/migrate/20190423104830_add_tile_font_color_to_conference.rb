class AddTileFontColorToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :tile_font_color, :string, :default => "#ffffff"
  end
end
