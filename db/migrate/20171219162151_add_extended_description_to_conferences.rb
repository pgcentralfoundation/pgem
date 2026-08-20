class AddExtendedDescriptionToConferences < ActiveRecord::Migration[4.2]
  def change
    add_column :conferences, :extended_description, :text
  end
end
