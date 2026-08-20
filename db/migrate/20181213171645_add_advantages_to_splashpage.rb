class AddAdvantagesToSplashpage < ActiveRecord::Migration[4.2]
  def change
    add_column :splashpages, :include_advantages, :boolean, default: false
  end
end
