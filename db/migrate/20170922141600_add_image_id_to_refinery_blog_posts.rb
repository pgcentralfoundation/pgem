class AddImageIdToRefineryBlogPosts < ActiveRecord::Migration[4.2]
  def change
    add_column :refinery_blog_posts, :image_id, :integer
  end
end
