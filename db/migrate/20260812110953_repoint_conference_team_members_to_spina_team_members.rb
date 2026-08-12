class RepointConferenceTeamMembersToSpinaTeamMembers < ActiveRecord::Migration[8.1]
  def up
    remove_foreign_key :conference_team_members, :refinery_team_members
    rename_column :conference_team_members, :refinery_team_member_id, :team_member_id
    # validate: false because spina_team_members is still empty at this point - existing
    # conference_team_members rows still hold the old refinery_team_members ids, and those
    # only become valid spina_team_members ids once spina_team_members:migrate has imported
    # the data (preserving the original ids). See ValidateSpinaTeamMembersForeignKey below.
    add_foreign_key :conference_team_members, :spina_team_members, column: :team_member_id, validate: false
  end

  def down
    remove_foreign_key :conference_team_members, :spina_team_members, column: :team_member_id
    rename_column :conference_team_members, :team_member_id, :refinery_team_member_id
    add_foreign_key :conference_team_members, :refinery_team_members
  end
end
