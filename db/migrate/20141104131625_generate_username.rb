class GenerateUsername < ActiveRecord::Migration[4.2]
  class TempUser < ActiveRecord::Base
    self.table_name = 'users'
  end

  def change
    TempUser.all.each do |user|
      if user.username.blank?
        username = user.email.split('@')[0]
        if TempUser.find_by(username: username)
          username = username + user.id.to_s
        end
        user.update(username: username)
      end
    end
  end
end
