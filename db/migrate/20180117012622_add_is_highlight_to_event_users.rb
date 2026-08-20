class AddIsHighlightToEventUsers < ActiveRecord::Migration[4.2]
  def self.up
    add_column :event_users, :is_highlight, :boolean, default: false
  end

  def self.down
    remove_column :event_users, :is_highlight
  end
end
