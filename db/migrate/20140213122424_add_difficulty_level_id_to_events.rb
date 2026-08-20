class AddDifficultyLevelIdToEvents < ActiveRecord::Migration[4.2]
  def change
    add_column :events, :difficulty_level_id, :integer
  end
end
