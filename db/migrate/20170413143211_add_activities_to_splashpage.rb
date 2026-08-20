class AddActivitiesToSplashpage < ActiveRecord::Migration[4.2]
  def change
    add_column :splashpages, :include_activities, :boolean, default: false
  end
end
