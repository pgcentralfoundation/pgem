# This migration comes from refinery_resources (originally 20150430180959)
# Refinery::Resource no longer exists (gem removed), so this creates the translation table
# directly rather than via the removed globalize create_translation_table! - shape confirmed
# against the already-populated pgconforg.refinery_resource_translations.
class AddTranslatedTitleToRefineryResources < ActiveRecord::Migration[4.2]
  def up
    create_table :refinery_resource_translations do |t|
      t.string :locale, null: false
      t.integer :refinery_resource_id, null: false
      t.string :resource_title
      t.timestamps null: false
    end

    add_index :refinery_resource_translations, :locale
    add_index :refinery_resource_translations, :refinery_resource_id
  end

  def down
    drop_table :refinery_resource_translations
  end
end
