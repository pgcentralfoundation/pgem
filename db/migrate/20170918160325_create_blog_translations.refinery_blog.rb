# This migration comes from refinery_blog (originally 20120530102901)
# Refinery::Blog::Post no longer has the globalize `translates` declaration this used to rely
# on (create_translation_table!/drop_translation_table!), so this creates the same translation
# table directly - shape confirmed against the already-populated pgconforg.refinery_blog_post_translations.
# No :migrate_data step: on a fresh DB there's nothing yet to migrate into it.
class CreateBlogTranslations < ActiveRecord::Migration[4.2]
  def up
    create_table :refinery_blog_post_translations do |t|
      t.text :body
      t.text :custom_teaser
      t.string :custom_url
      t.string :locale, null: false
      t.integer :refinery_blog_post_id, null: false
      t.string :slug
      t.string :title
      t.timestamps null: false
    end

    add_index :refinery_blog_post_translations, :locale
    add_index :refinery_blog_post_translations, :refinery_blog_post_id
  end

  def down
    drop_table :refinery_blog_post_translations
  end
end
