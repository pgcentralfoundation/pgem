class ChangePersonIdToUserIdInVotes < ActiveRecord::Migration[4.2]
  # See 20140801164901_move_conference_media_to_commercial.rb for why this is needed.
  disable_ddl_transaction!

  class TempPerson < ActiveRecord::Base
    self.table_name = 'people'
  end

  class TempVote < ActiveRecord::Base
    self.table_name = 'votes'
  end

  def change
    add_column :votes, :user_id, :integer

    TempPerson.all.each do |t|
      votes = TempVote.where(person_id: t.id)

      unless votes.empty?
        votes.each do |v|
          v.user_id = t.user_id
          v.save!
        end
      end
    end

    remove_column :votes, :person_id
  end
end
