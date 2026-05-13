module SpinaAdminBlogPostControllerOverride
  private

  def post_params
    params.require(:post).permit(:title, :content, :excerpt, :published_at, :draft, :tag_list, :image_id)
  end
end

Spina::Admin::Blog::PostsController.prepend(SpinaAdminBlogPostControllerOverride)
