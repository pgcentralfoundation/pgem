# frozen_string_literal: true

# Fixes will_paginate/BootstrapPagination::Rails generating pagination links
# that point at the /blog/feed atom route instead of the current page.
#
# The default renderer's `url(page)` builds each link via
# `url_for(controller:, action:, page:)`. That's ambiguous here: config/routes.rb
# registers a second route (`blog_feed`) for the exact same
# Spina::Blog::Posts#index controller/action (to move the atom feed above
# other Spina routes), and Rails resolves the ambiguity by declaration order,
# picking blog_feed over the real index route.
#
# Sidestep the ambiguity entirely by rebuilding the URL from the current
# request's actual path instead of a hash-based route lookup. This also
# preserves context correctly on /blog/tagged/:id/:tag, which renders this
# same index template with a tag filter.
class BlogPaginationRenderer < BootstrapPagination::Rails
  protected

  def url(page)
    query = @template.request.query_parameters.merge(param_name => page)
    "#{@template.request.path}?#{query.to_query}"
  end
end
