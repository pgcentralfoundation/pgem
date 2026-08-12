# Spina's frontend controllers inherit from the host app's ApplicationController, so they need
# this include for their own bare route helpers (page_path, blog_post_path, etc). Scoped here
# instead of on ApplicationController directly, which used to break every bare admin_*_path
# helper in the main app's /admin views (see memory: pgem-admin-routes-spina-collision-fix).
Spina::ApplicationController.class_eval do
  helper  Spina::Engine.routes.url_helpers
  include Spina::Engine.routes.url_helpers
end
