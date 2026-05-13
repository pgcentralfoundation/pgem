module SpinaBlogPostControllerOverride
  def tagged
    # Get posts tagged with the tag name from params
    @posts = Spina::Blog::Post.available.live
                              .tagged_with(params[:tag])
                              .order(published_at: :desc)
                              .page(params[:page])
    
    # Support admin preview of drafts, matching original index logic
    @posts = @posts.unscope(where: :draft) if current_spina_user&.admin?

    render 'blog/posts/index', layout: theme_layout
  end
end

Spina::Blog::PostsController.prepend(SpinaBlogPostControllerOverride)