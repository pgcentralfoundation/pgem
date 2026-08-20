# This migration comes from refinery_blog (originally 20120227022021)
class AddSlugToPostsAndCategories < ActiveRecord::Migration[4.2]
  def change
    add_column Refinery::Blog::Post.table_name, :slug, :string
    add_index Refinery::Blog::Post.table_name, :slug

    add_column :refinery_blog_categories, :slug, :string
    add_index :refinery_blog_categories, :slug
  end
end