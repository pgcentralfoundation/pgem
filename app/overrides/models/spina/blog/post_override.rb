Spina::Blog::Post.class_eval do
  # add tagging to spina blogs
  acts_as_taggable_on :tags

  def self.per_page
    10
  end

  def self.newest_first
    order("published_at DESC")
  end

  def self.recent(count)
    newest_first.live.limit(count)
  end
end