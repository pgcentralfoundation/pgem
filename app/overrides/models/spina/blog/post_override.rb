Spina::Blog::Post.class_eval do
  # add tagging to spina blogs
  acts_as_taggable_on :tags

  def self.per_page
    10
  end
end