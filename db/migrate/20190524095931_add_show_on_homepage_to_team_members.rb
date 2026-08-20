class AddShowOnHomepageToTeamMembers < ActiveRecord::Migration[4.2]
  def change
    add_column :refinery_team_members, :show_on_homepage, :boolean, default: false
  end
end

