class CreateSpinaTeamMembers < ActiveRecord::Migration[8.1]
  def change
    create_table :spina_team_members do |t|
      t.string  :firstname, null: false
      t.string  :middlename
      t.string  :lastname
      t.string  :role
      t.text    :description
      t.references :photo, foreign_key: { to_table: :spina_images }
      t.string  :twitter
      t.string  :linkedin
      t.integer :position
      t.boolean :show_on_homepage, default: false

      t.timestamps
    end
  end
end
