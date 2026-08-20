class RemoveColsFromSponsors < ActiveRecord::Migration[4.2]
  def change
    remove_column :sponsors, :conference_id 
    remove_column :sponsors, :sponsorship_level_id
  end
end
