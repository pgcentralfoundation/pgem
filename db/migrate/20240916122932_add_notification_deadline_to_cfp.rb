class AddNotificationDeadlineToCfp < ActiveRecord::Migration[4.2]
  def change
    add_column :cfps, :notification_deadline, :date
  end
end
