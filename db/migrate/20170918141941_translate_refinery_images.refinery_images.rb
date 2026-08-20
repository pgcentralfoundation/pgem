# This migration comes from refinery_images (originally 20150430171341)
# Refinery::Image exists (app/models/refinery/image.rb) but no longer has the globalize
# `translates` declaration this used to rely on, so this creates the translation table
# directly - shape confirmed against the already-populated pgconforg.refinery_image_translations.
class TranslateRefineryImages < ActiveRecord::Migration[4.2]
  def self.up
    create_table :refinery_image_translations do |t|
      t.string :image_alt
      t.string :image_title
      t.string :locale, null: false
      t.integer :refinery_image_id, null: false
      t.timestamps null: false
    end

    add_index :refinery_image_translations, :locale
    add_index :refinery_image_translations, :refinery_image_id
  end

  def self.down
    drop_table :refinery_image_translations
  end
end
