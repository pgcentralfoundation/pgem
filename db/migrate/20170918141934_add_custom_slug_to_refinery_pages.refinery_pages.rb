# This migration comes from refinery_pages (originally 20140105190324)
class AddCustomSlugToRefineryPages < ActiveRecord::Migration[4.2]
  def up
    # Refinery::Page no longer exists (gem removed) - check the real table's columns
    # directly instead, since the "custom_slug" column already exists as of the earlier
    # create_refinerycms_pages_schema migration.
    unless column_exists?(:refinery_pages, :custom_slug)
      add_column :refinery_pages, :custom_slug, :string
    end
  end

  def down
    if column_exists?(:refinery_pages, :custom_slug)
      remove_column :refinery_pages, :custom_slug
    end
  end
end
