# This migration comes from refinery_blog (originally 20120601151114)
# Same reasoning as 20170918160325_create_blog_translations.refinery_blog.rb - creates the
# translation table directly rather than via the removed globalize create_translation_table!.
class CreateCategoryTranslations < ActiveRecord::Migration[4.2]
  def up
    create_table :refinery_blog_category_translations do |t|
      t.string :locale, null: false
      t.integer :refinery_blog_category_id, null: false
      t.string :slug
      t.string :title
      t.timestamps null: false
    end

    add_index :refinery_blog_category_translations, :locale
    # Default index name exceeds Postgres' 63-char limit; matches the shortened name globalize
    # itself generated when this originally ran (confirmed against the live schema dump).
    add_index :refinery_blog_category_translations, :refinery_blog_category_id,
              name: 'index_a0315945e6213bbe0610724da0ee2de681b77c31'
  end

  def down
    drop_table :refinery_blog_category_translations
  end
end
