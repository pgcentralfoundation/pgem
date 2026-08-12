# Pins our team_members_sortable_controller.js into Spina's own importmap (separate from the
# host app's asset pipeline), additively - doesn't touch Spina's own pinned controllers, so
# navigations/pages keep using the gem's "sortable" controller unchanged.
Rails.application.config.after_initialize do
  Spina.config.importmap.pin_all_from(
    Rails.root.join('app/assets/javascripts/spina_overrides/controllers'),
    under: 'controllers',
    to: 'spina_overrides/controllers'
  )
end
