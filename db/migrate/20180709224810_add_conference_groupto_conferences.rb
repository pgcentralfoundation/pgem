class AddConferenceGrouptoConferences < ActiveRecord::Migration[4.2]
  def self.up
    add_reference :conferences, :conference_group, foreign_key: true
  end

  def self.down
    remove_foreign_key :conferences, :conference_groups
    remove_reference :conferences, :conference_group
  end
end
