# This migration comes from refinery_pages (originally 20100913234708)
class CreateRefinerycmsPagesSchema < ActiveRecord::Migration[4.2]
  def up
    create_table :refinery_page_parts do |t|
      t.integer  :refinery_page_id
      t.string   :title
      t.text     :body
      t.integer  :position

      t.timestamps
    end

    add_index :refinery_page_parts, :id
    add_index :refinery_page_parts, :refinery_page_id

    create_table :refinery_pages do |t|
      t.integer   :parent_id
      t.string    :path
      t.string    :slug
      t.string    :custom_slug
      t.boolean   :show_in_menu,        :default => true
      t.string    :link_url
      t.string    :menu_match
      t.boolean   :deletable,           :default => true
      t.boolean   :draft,               :default => false
      t.boolean   :skip_to_first_child, :default => false
      t.integer   :lft
      t.integer   :rgt
      t.integer   :depth
      t.string    :view_template
      t.string    :layout_template

      t.timestamps
    end

    add_index :refinery_pages, :depth
    add_index :refinery_pages, :id
    add_index :refinery_pages, :lft
    add_index :refinery_pages, :parent_id
    add_index :refinery_pages, :rgt

    # Refinery::Page/PagePart no longer exist (gem removed), so these translation tables are
    # created directly rather than via the removed globalize create_translation_table! - shape
    # confirmed against the already-populated pgconforg.refinery_page(_part)_translations.
    create_table :refinery_page_part_translations do |t|
      t.text :body
      t.string :locale, null: false
      t.integer :refinery_page_part_id, null: false
      t.timestamps null: false
    end
    add_index :refinery_page_part_translations, :locale
    add_index :refinery_page_part_translations, :refinery_page_part_id

    create_table :refinery_page_translations do |t|
      t.string :custom_slug
      t.string :locale, null: false
      t.string :menu_title
      t.integer :refinery_page_id, null: false
      t.string :slug
      t.string :title
      t.timestamps null: false
    end
    add_index :refinery_page_translations, :locale
    add_index :refinery_page_translations, :refinery_page_id
  end

  def down
    drop_table :refinery_page_parts
    drop_table :refinery_pages
    drop_table :refinery_page_part_translations
    drop_table :refinery_page_translations
  end
end
