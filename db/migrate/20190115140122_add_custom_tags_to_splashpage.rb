class AddCustomTagsToSplashpage < ActiveRecord::Migration[4.2]
  def change
    add_column :splashpages, :custom_tags, :text
  end
end
