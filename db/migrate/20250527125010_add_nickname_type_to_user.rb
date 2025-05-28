class AddNicknameTypeToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :nickname_type, :integer, default: 0
  end
end
