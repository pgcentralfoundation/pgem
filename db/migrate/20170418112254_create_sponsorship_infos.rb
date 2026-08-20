class CreateSponsorshipInfos < ActiveRecord::Migration[4.2]
  def change
    create_table :sponsorship_infos do |t|
      t.text :description
      t.references :conference, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
