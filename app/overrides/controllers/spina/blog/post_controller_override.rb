module SpinaBlogPostControllerOverride
  def tagged
    # No pinned post on a tag-filtered view - same as page 2+ on the plain
    # index (find_posts below), and index.html.haml expects @featured_posts
    # to always be set (even to an empty relation) since it's shared between
    # both actions.
    @featured_posts = Spina::Blog::Post.none

    # Get posts tagged with the tag name from params
    @posts = Spina::Blog::Post.available.live
                              .tagged_with(params[:tag])
                              .order(published_at: :desc)
                              .page(params[:page])

    # Support admin preview of drafts, matching original index logic
    @posts = @posts.unscope(where: :draft) if current_spina_user&.admin?

    render 'blog/posts/index', layout: theme_layout
  end

  private

  # Pins currently_featured posts above the paginated list, on page 1 only -
  # excluded from @posts by id (not by the raw `featured` scope) so a post
  # whose 1-month highlight window has lapsed still shows up as a normal
  # card in @posts instead of vanishing from the index entirely.
  def find_posts
    featured_scope = Spina::Blog::Post.available.live.currently_featured.order(published_at: :desc)
    featured_scope = featured_scope.unscope(where: :draft) if current_spina_user&.admin?

    @featured_posts = params[:page].to_i > 1 ? Spina::Blog::Post.none : featured_scope
    @posts = Spina::Blog::Post.available.live
                              .where.not(id: featured_scope.select(:id))
                              .order(published_at: :desc)
                              .page(params[:page])
  end
end

Spina::Blog::PostsController.prepend(SpinaBlogPostControllerOverride)