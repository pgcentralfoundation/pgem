Spina::Blog::Post.class_eval do
  # add tagging to spina blogs
  acts_as_taggable_on :tags

  # A post only gets the index page's pinned/gold treatment for a month
  # after its published_at - after that it's still `featured: true` in the
  # DB (untouched), it just quietly rejoins the regular list.
  scope :currently_featured, -> { featured.where('published_at >= ?', 1.month.ago) }

  # Only one post is ever featured at a time - marking one featured
  # unfeatures every other post.
  before_save :unfeature_other_posts, if: -> { featured? && featured_changed? }

  # Featuring an older, already-published post would otherwise land it
  # outside currently_featured's 1-month window immediately - bump
  # published_at to now so it actually gets highlighted. Only for existing
  # posts (persisted?) that were already live (not draft, not scheduled).
  before_save :refresh_published_at_when_featured, if: -> {
    persisted? && featured_changed? && featured? &&
      !draft_was && published_at_was.present? && published_at_was <= Time.current
  }

  def self.per_page
    10
  end

  def self.newest_first
    order("published_at DESC")
  end

  def self.recent(count)
    newest_first.live.limit(count)
  end

  private

  def unfeature_other_posts
    self.class.where(featured: true).where.not(id: id).update_all(featured: false)
  end

  def refresh_published_at_when_featured
    self.published_at = Time.current
  end
end