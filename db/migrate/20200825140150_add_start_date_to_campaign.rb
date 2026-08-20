class AddStartDateToCampaign < ActiveRecord::Migration[4.2]
  def change
    add_column :campaigns, :started_at, :Date
  end
end
