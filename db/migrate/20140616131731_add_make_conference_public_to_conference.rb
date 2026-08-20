class AddMakeConferencePublicToConference < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :make_conference_public, :boolean, default: false
  end
end
