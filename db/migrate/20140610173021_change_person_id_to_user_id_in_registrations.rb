class ChangePersonIdToUserIdInRegistrations < ActiveRecord::Migration[4.2]
  # See 20140801164901_move_conference_media_to_commercial.rb for why this is needed.
  disable_ddl_transaction!

  class TempPerson < ActiveRecord::Base
    self.table_name = 'people'
  end

  class TempRegistration < ActiveRecord::Base
    self.table_name = 'registrations'
  end

  def change
    add_column :registrations, :user_id, :integer

    TempPerson.all.each do |t|
      registrations = TempRegistration.where(person_id: t.id)

      unless registrations.empty?
        registrations.each do |r|
          r.user_id = t.user_id
          r.save!
        end
      end
    end

    remove_column :registrations, :person_id
  end
end
