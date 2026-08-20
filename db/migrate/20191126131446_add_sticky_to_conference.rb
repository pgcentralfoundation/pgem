class AddStickyToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :sticky, :boolean, default: false
  end
end
