require 'acts-as-taggable-on'

module Refinery
  module Blog
    class Post < ActiveRecord::Base

      self.table_name = 'refinery_blog_posts'

      attribute :title
      attribute :body
      attribute :custom_url
      attribute :custom_teaser
      attribute :slug
      after_save {translations.collect(&:save)}


      class Translation < ActiveRecord::Base
        self.table_name = 'refinery_blog_post_translations'
          belongs_to :blog_post, 
             class_name: "::Refinery::Blog::Post", 
             foreign_key: :refinery_blog_post_id 
      end

      has_many :translations, 
               class_name: "::Refinery::Blog::Post::Translation", 
               foreign_key: :refinery_blog_post_id


      acts_as_taggable

      belongs_to :author, proc { readonly(true) }, class_name: "User", foreign_key: :user_id, optional: true


      def next
        self.class.next(self)
      end

      def prev
        self.class.previous(self)
      end

      def live?
        !draft && published_at <= Time.now
      end

      def author_username
        author.try(:username) || username
      end

      class << self

        def with_globalize(conditions = {})
          # This join makes the columns available for direct SELECT or WHERE
        joins(:translations)
          .where(refinery_blog_post_translations: { locale: I18n.locale })
          .select("refinery_blog_posts.*")
          .select("refinery_blog_post_translations.title AS title")
          .select("refinery_blog_post_translations.body AS body")
          .select("refinery_blog_post_translations.slug AS translated_slug")
        end

        def by_month(date)
          newest_first.where(:published_at => date.beginning_of_month..date.end_of_month)
        end

        def by_year(date)
          newest_first.where(:published_at => date.beginning_of_year..date.end_of_year).with_globalize
        end

        def by_title(title)
          joins(:translations).find_by(:title => title)
        end

        def newest_first
          order("published_at DESC")
        end


      end
    end
  end
end
