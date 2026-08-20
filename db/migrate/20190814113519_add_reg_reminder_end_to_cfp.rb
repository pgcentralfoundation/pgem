class AddRegReminderEndToCfp < ActiveRecord::Migration[4.2]
  def change
    add_column :cfps, :reg_reminder_end, :date
  end
end
