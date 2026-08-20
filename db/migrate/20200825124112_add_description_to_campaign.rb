class AddDescriptionToCampaign < ActiveRecord::Migration[4.2]
  def change
    add_column :campaigns, :description, :text
  end
end
