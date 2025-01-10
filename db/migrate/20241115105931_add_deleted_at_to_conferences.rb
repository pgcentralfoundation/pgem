class AddDeletedAtToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :deleted_at, :datetime
    add_index :conferences, :deleted_at
  end
end
