class AddSpeakersPendingToEvent < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :speakers_pending, :boolean, defaut: false
  end
end
