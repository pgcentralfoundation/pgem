class AddLanguagesToPeople < ActiveRecord::Migration[4.2]
  def change
    add_column :people, :languages, :string
  end
end
