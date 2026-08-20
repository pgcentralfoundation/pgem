class DropOldAhoyTables < ActiveRecord::Migration[4.2]
  def change
    drop_table :ahoy_events
    drop_table :visits
  end
end
