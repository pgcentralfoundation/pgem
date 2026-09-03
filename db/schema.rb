# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.1].define(version: 2026_08_12_110953) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "tablefunc"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.string "name", null: false
    t.bigint "record_id", null: false
    t.string "record_type", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "filename", null: false
    t.string "key", null: false
    t.text "metadata"
    t.string "service_name", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "activities", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "name"
    t.string "photo_content_type"
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at", precision: nil
    t.string "picture"
    t.datetime "updated_at", precision: nil
    t.string "website_link"
  end

  create_table "advantages", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "name"
    t.string "photo_content_type"
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at", precision: nil
    t.string "picture"
    t.datetime "updated_at", precision: nil
  end

  create_table "ahoy_events", id: :serial, force: :cascade do |t|
    t.string "name"
    t.jsonb "properties"
    t.datetime "time", precision: nil
    t.integer "user_id"
    t.integer "visit_id"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
  end

  create_table "ahoy_visits", id: :serial, force: :cascade do |t|
    t.string "app_version"
    t.string "browser"
    t.string "city"
    t.string "country"
    t.string "device_type"
    t.string "ip"
    t.text "landing_page"
    t.decimal "latitude", precision: 10, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.string "os"
    t.string "os_version"
    t.string "platform"
    t.text "referrer"
    t.string "referring_domain"
    t.string "region"
    t.datetime "started_at", precision: nil
    t.text "user_agent"
    t.integer "user_id"
    t.string "utm_campaign"
    t.string "utm_content"
    t.string "utm_medium"
    t.string "utm_source"
    t.string "utm_term"
    t.string "visit_token"
    t.string "visitor_token"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "answers", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "benefit_responses", id: :serial, force: :cascade do |t|
    t.integer "benefit_id"
    t.boolean "bool_response"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil, null: false
    t.string "file_response"
    t.integer "sponsorship_id"
    t.text "text_response"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true
  end

  create_table "benefits", id: :serial, force: :cascade do |t|
    t.integer "category"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.datetime "due_date", precision: nil
    t.string "name"
    t.datetime "updated_at", precision: nil
    t.integer "value_type"
    t.index ["conference_id"], name: "index_benefits_on_conference_id"
  end

  create_table "boomset_guests", id: :serial, force: :cascade do |t|
    t.integer "boomset_guest"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.integer "integration_id"
    t.integer "registration_id"
    t.string "token"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id", "boomset_guest"], name: "index_boomset_guests_on_conference_id_and_boomset_guest"
    t.index ["conference_id", "registration_id"], name: "index_boomset_guests_on_conference_id_and_registration_id", unique: true
    t.index ["conference_id", "token"], name: "index_boomset_guests_on_conference_id_and_token"
  end

  create_table "boomset_ticket_configs", id: :serial, force: :cascade do |t|
    t.integer "boomset_registration_type"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.integer "integration_id"
    t.integer "ticket_id"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id", "ticket_id", "integration_id"], name: "bs_conf_tix_int_idx", unique: true
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "name"
    t.integer "sponsor_id"
    t.date "started_at"
    t.datetime "updated_at", precision: nil
    t.string "utm_campaign"
    t.string "utm_content"
    t.string "utm_medium"
    t.string "utm_source"
    t.string "utm_term"
    t.index ["sponsor_id"], name: "index_campaigns_on_sponsor_id"
  end

  create_table "cfps", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.date "end_date", null: false
    t.date "notification_deadline"
    t.integer "program_id"
    t.date "reg_reminder_end"
    t.date "start_date", null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "code_types", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.index ["title"], name: "index_code_types_on_title", unique: true
  end

  create_table "codes", id: :serial, force: :cascade do |t|
    t.integer "code_type_id"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.integer "discount"
    t.integer "max_uses", default: 0, null: false
    t.string "name"
    t.integer "sponsor_id"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id", "name"], name: "index_codes_on_conference_id_and_name", unique: true
    t.index ["sponsor_id"], name: "index_codes_on_sponsor_id"
  end

  create_table "codes_tickets", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "ticket_id"
    t.index ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", precision: nil
    t.integer "lft"
    t.integer "parent_id"
    t.integer "rgt"
    t.string "subject"
    t.string "title", limit: 50, default: ""
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "commercials", id: :serial, force: :cascade do |t|
    t.string "commercial_id"
    t.string "commercial_type"
    t.integer "commercialable_id"
    t.string "commercialable_type"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "url"
  end

  create_table "conference_groups", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "name", null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "conference_team_members", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.integer "position", null: false
    t.integer "team_member_id", null: false
    t.index ["conference_id"], name: "index_conference_team_members_on_conference_id"
  end

  create_table "conferences", id: :serial, force: :cascade do |t|
    t.string "background_file_name"
    t.string "braintree_merchant_account"
    t.string "color"
    t.integer "conference_group_id"
    t.datetime "created_at", precision: nil
    t.string "default_currency", default: "USD"
    t.datetime "deleted_at", precision: nil
    t.text "description"
    t.boolean "digital"
    t.date "end_date", null: false
    t.integer "end_hour", default: 20
    t.text "events_per_week"
    t.text "extended_description"
    t.string "guid", null: false
    t.string "logo_file_name"
    t.string "picture"
    t.integer "registration_limit", default: 0
    t.boolean "require_itinerary"
    t.integer "revision"
    t.string "short_title", null: false
    t.date "start_date", null: false
    t.integer "start_hour", default: 9
    t.boolean "sticky", default: false
    t.integer "ticket_layout", default: 0
    t.string "timezone", null: false
    t.string "title", null: false
    t.datetime "updated_at", precision: nil
    t.boolean "use_pg_flow", default: true
    t.boolean "use_vdays", default: false
    t.boolean "use_volunteers"
    t.boolean "use_vpositions", default: false
    t.index ["deleted_at"], name: "index_conferences_on_deleted_at"
  end

  create_table "conferences_codes", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "conference_id"
    t.index ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true
  end

  create_table "conferences_policies", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "policy_id"
    t.index ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true
  end

  create_table "conferences_questions", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "question_id"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "city"
    t.integer "conference_id"
    t.string "country"
    t.datetime "created_at", precision: nil
    t.string "email"
    t.string "facebook"
    t.string "googleplus"
    t.string "instagram"
    t.string "name"
    t.string "postal_code"
    t.string "social_tag"
    t.string "sponsor_email"
    t.string "state"
    t.string "street1"
    t.string "street2"
    t.string "twitter"
    t.datetime "updated_at", precision: nil
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "attempts", default: 0, null: false
    t.datetime "created_at", precision: nil
    t.datetime "failed_at", precision: nil
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "locked_at", precision: nil
    t.string "locked_by"
    t.integer "priority", default: 0, null: false
    t.string "queue"
    t.datetime "run_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "difficulty_levels", id: :serial, force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.integer "program_id"
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "email_settings", id: :serial, force: :cascade do |t|
    t.text "accepted_body"
    t.string "accepted_subject"
    t.text "assign_ticket_body"
    t.string "assign_ticket_subject"
    t.text "cfp_dates_updated_body"
    t.string "cfp_dates_updated_subject"
    t.text "conference_dates_updated_body"
    t.string "conference_dates_updated_subject"
    t.integer "conference_id"
    t.text "conference_registration_dates_updated_body"
    t.string "conference_registration_dates_updated_subject"
    t.text "confirmed_without_registration_body"
    t.string "confirmed_without_registration_subject"
    t.datetime "created_at", precision: nil
    t.text "pending_assign_ticket_body"
    t.string "pending_assign_ticket_subject"
    t.text "program_schedule_public_body"
    t.string "program_schedule_public_subject"
    t.text "purchase_confirmation_body"
    t.string "purchase_confirmation_subject"
    t.text "registration_body"
    t.string "registration_subject"
    t.text "rejected_body"
    t.string "rejected_subject"
    t.boolean "send_on_accepted", default: false
    t.boolean "send_on_cfp_dates_updated", default: false
    t.boolean "send_on_conference_dates_updated", default: false
    t.boolean "send_on_conference_registration_dates_updated", default: false
    t.boolean "send_on_confirmed_without_registration", default: false
    t.boolean "send_on_program_schedule_public", default: false
    t.boolean "send_on_registration", default: false
    t.boolean "send_on_rejected", default: false
    t.boolean "send_on_venue_updated", default: false
    t.boolean "send_ticket_pdf", default: true
    t.text "ticket_confirmation_body"
    t.string "ticket_confirmation_subject"
    t.datetime "updated_at", precision: nil
    t.text "venue_updated_body"
    t.string "venue_updated_subject"
  end

  create_table "event_schedules", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "event_id"
    t.integer "room_id"
    t.integer "schedule_id"
    t.datetime "start_time", precision: nil
    t.datetime "updated_at", precision: nil, null: false
    t.index ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
    t.index ["room_id"], name: "index_event_schedules_on_room_id"
    t.index ["schedule_id"], name: "index_event_schedules_on_schedule_id"
  end

  create_table "event_types", id: :serial, force: :cascade do |t|
    t.string "color"
    t.string "description"
    t.boolean "internal_event", default: false
    t.integer "length", default: 30
    t.integer "maximum_abstract_length", default: 500
    t.integer "minimum_abstract_length", default: 0
    t.integer "program_id"
    t.string "title", null: false
  end

  create_table "event_users", id: :serial, force: :cascade do |t|
    t.string "comment"
    t.datetime "created_at", precision: nil
    t.integer "event_id"
    t.string "event_role", default: "participant", null: false
    t.boolean "is_highlight", default: false
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.text "abstract"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.integer "difficulty_level_id"
    t.string "document"
    t.integer "event_type_id"
    t.string "guid", null: false
    t.boolean "is_highlight", default: false
    t.string "language"
    t.integer "max_attendees"
    t.integer "program_id"
    t.string "progress", default: "new", null: false
    t.text "proposal_additional_speakers"
    t.boolean "public", default: true
    t.boolean "require_registration"
    t.integer "room_id"
    t.string "slug"
    t.boolean "speakers_pending"
    t.datetime "start_time", precision: nil
    t.string "state", default: "new", null: false
    t.string "subtitle"
    t.integer "ticket_id"
    t.string "title", null: false
    t.integer "track_id"
    t.datetime "updated_at", precision: nil
    t.integer "week"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["ticket_id"], name: "index_events_on_ticket_id"
  end

  create_table "events_registrations", id: :serial, force: :cascade do |t|
    t.boolean "attended", default: false, null: false
    t.datetime "created_at", precision: nil
    t.integer "event_id"
    t.integer "registration_id"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "scope"
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "integrations", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.string "integration_config_key"
    t.integer "integration_type"
    t.string "key"
    t.datetime "updated_at", precision: nil
    t.string "url"
    t.index ["conference_id", "integration_type"], name: "index_integrations_on_conference_id_and_integration_type", unique: true
  end

  create_table "lodgings", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "name"
    t.string "photo_content_type"
    t.string "photo_file_name"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at", precision: nil
    t.string "picture"
    t.datetime "updated_at", precision: nil
    t.string "website_link"
  end

  create_table "openids", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "email"
    t.string "provider"
    t.string "uid"
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
  end

  create_table "payment_methods", id: :serial, force: :cascade do |t|
    t.string "braintree_environment"
    t.string "braintree_merchant_account"
    t.string "braintree_merchant_id"
    t.string "braintree_private_key"
    t.string "braintree_public_key"
    t.integer "conference_id", null: false
    t.datetime "created_at", precision: nil
    t.string "environment", null: false
    t.string "gateway", null: false
    t.string "payu_service_domain"
    t.string "payu_signature_key"
    t.string "payu_store_id"
    t.string "payu_store_name"
    t.string "payu_webservice_name"
    t.string "payu_webservice_password"
    t.string "stripe_publishable_key"
    t.string "stripe_secret_key"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id", "environment"], name: "index_payment_methods_on_conference_id_and_environment", unique: true
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.integer "amount"
    t.string "authorization_code"
    t.integer "conference_id", null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "last4"
    t.string "reference"
    t.integer "status", default: 0, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id", null: false
    t.index ["reference"], name: "index_payments_on_reference", unique: true
  end

  create_table "physical_tickets", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "event_id"
    t.string "pending_assignment"
    t.integer "registration_id", null: false
    t.integer "ticket_purchase_id", null: false
    t.string "token"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id", null: false
    t.index "lower((pending_assignment)::text)", name: "pending_ticket_assignment_idx", where: "(pending_assignment IS NOT NULL)"
    t.index ["registration_id"], name: "index_physical_tickets_on_registration_id"
    t.index ["token"], name: "index_physical_tickets_on_token", unique: true
    t.index ["user_id"], name: "index_physical_tickets_on_user_id"
  end

  create_table "policies", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.boolean "global"
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "polls", id: :serial, force: :cascade do |t|
    t.text "comment"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.integer "survey_id"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id"], name: "index_polls_on_conference_id"
  end

  create_table "programs", id: :serial, force: :cascade do |t|
    t.boolean "blind_voting", default: false
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.string "languages"
    t.integer "rating", default: 0
    t.boolean "schedule_fluid", default: false
    t.boolean "schedule_public", default: false
    t.integer "selected_schedule_id"
    t.datetime "updated_at", precision: nil
    t.datetime "voting_end_date", precision: nil
    t.datetime "voting_start_date", precision: nil
    t.index ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id"
  end

  create_table "qanswers", id: :serial, force: :cascade do |t|
    t.integer "answer_id"
    t.datetime "created_at", precision: nil
    t.integer "question_id"
    t.datetime "updated_at", precision: nil
  end

  create_table "qanswers_registrations", id: false, force: :cascade do |t|
    t.integer "qanswer_id", null: false
    t.integer "registration_id", null: false
  end

  create_table "question_types", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.boolean "global"
    t.integer "question_type_id"
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "refinery_blog_categories", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.index ["id"], name: "index_refinery_blog_categories_on_id"
    t.index ["slug"], name: "index_refinery_blog_categories_on_slug"
  end

  create_table "refinery_blog_categories_blog_posts", id: :serial, force: :cascade do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
    t.index ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp"
  end

  create_table "refinery_blog_category_translations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "locale", null: false
    t.integer "refinery_blog_category_id", null: false
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_refinery_blog_category_translations_on_locale"
    t.index ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31"
  end

  create_table "refinery_blog_comments", id: :serial, force: :cascade do |t|
    t.integer "blog_post_id"
    t.text "body"
    t.datetime "created_at", precision: nil
    t.string "email"
    t.string "name"
    t.boolean "spam"
    t.string "state"
    t.datetime "updated_at", precision: nil
    t.index ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id"
    t.index ["id"], name: "index_refinery_blog_comments_on_id"
  end

  create_table "refinery_blog_post_translations", id: :serial, force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.text "custom_teaser"
    t.string "custom_url"
    t.string "locale", null: false
    t.integer "refinery_blog_post_id", null: false
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_refinery_blog_post_translations_on_locale"
    t.index ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id"
  end

  create_table "refinery_blog_posts", id: :serial, force: :cascade do |t|
    t.integer "access_count", default: 0
    t.text "body"
    t.datetime "created_at", precision: nil
    t.text "custom_teaser"
    t.string "custom_url"
    t.boolean "draft"
    t.integer "image_id"
    t.datetime "published_at", precision: nil
    t.string "slug"
    t.string "source_url"
    t.string "source_url_title"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.index ["access_count"], name: "index_refinery_blog_posts_on_access_count"
    t.index ["id"], name: "index_refinery_blog_posts_on_id"
    t.index ["slug"], name: "index_refinery_blog_posts_on_slug"
  end

  create_table "refinery_community_events", id: :serial, force: :cascade do |t|
    t.string "author"
    t.text "body"
    t.datetime "created_at", precision: nil
    t.integer "position"
    t.datetime "published_at", precision: nil
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.string "url"
  end

  create_table "refinery_dynamicfields_dynamicfields", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "criteria", default: "page_layout"
    t.string "model_title"
    t.string "page_id"
    t.string "page_layout"
    t.integer "position"
    t.datetime "updated_at", precision: nil
  end

  create_table "refinery_dynamicfields_dynamicform_associations", id: :serial, force: :cascade do |t|
    t.integer "dynamicfield_id"
    t.integer "page_id"
  end

  create_table "refinery_dynamicfields_dynamicform_fields", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.integer "dynamicfield_id"
    t.string "field_id"
    t.string "field_label"
    t.string "field_type"
    t.integer "position"
    t.datetime "updated_at", precision: nil
  end

  create_table "refinery_dynamicfields_dynamicform_values", id: :serial, force: :cascade do |t|
    t.integer "dynamicform_association_id"
    t.integer "dynamicform_field_id"
    t.integer "image_id"
    t.integer "resource_id"
    t.string "string_value"
    t.text "text_value"
  end

  create_table "refinery_image_translations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "image_alt"
    t.string "image_title"
    t.string "locale", null: false
    t.integer "refinery_image_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_refinery_image_translations_on_locale"
    t.index ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id"
  end

  create_table "refinery_images", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "image_alt"
    t.integer "image_height"
    t.string "image_mime_type"
    t.string "image_name"
    t.integer "image_size"
    t.string "image_title"
    t.string "image_uid"
    t.integer "image_width"
    t.integer "parent_id"
    t.datetime "updated_at", precision: nil
  end

  create_table "refinery_meetups", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.text "description"
    t.datetime "end", precision: nil
    t.string "external_id"
    t.string "location"
    t.string "picture_url"
    t.integer "position"
    t.datetime "start", precision: nil
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.string "url"
  end

  create_table "refinery_page_part_translations", id: :serial, force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil, null: false
    t.string "locale", null: false
    t.integer "refinery_page_part_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_refinery_page_part_translations_on_locale"
    t.index ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id"
  end

  create_table "refinery_page_parts", id: :serial, force: :cascade do |t|
    t.text "body"
    t.datetime "created_at", precision: nil
    t.integer "position"
    t.integer "refinery_page_id"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.index ["id"], name: "index_refinery_page_parts_on_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id"
  end

  create_table "refinery_page_translations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "custom_slug"
    t.string "locale", null: false
    t.string "menu_title"
    t.integer "refinery_page_id", null: false
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_refinery_page_translations_on_locale"
    t.index ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id"
  end

  create_table "refinery_pages", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "custom_slug"
    t.boolean "deletable", default: true
    t.integer "depth"
    t.boolean "draft", default: false
    t.string "layout_template"
    t.integer "lft"
    t.string "link_url"
    t.string "menu_match"
    t.integer "parent_id"
    t.string "path"
    t.integer "rgt"
    t.boolean "show_in_menu", default: true
    t.boolean "skip_to_first_child", default: false
    t.string "slug"
    t.datetime "updated_at", precision: nil
    t.string "view_template"
    t.index ["depth"], name: "index_refinery_pages_on_depth"
    t.index ["id"], name: "index_refinery_pages_on_id"
    t.index ["lft"], name: "index_refinery_pages_on_lft"
    t.index ["parent_id"], name: "index_refinery_pages_on_parent_id"
    t.index ["rgt"], name: "index_refinery_pages_on_rgt"
  end

  create_table "refinery_resource_translations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "locale", null: false
    t.integer "refinery_resource_id", null: false
    t.string "resource_title"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_refinery_resource_translations_on_locale"
    t.index ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id"
  end

  create_table "refinery_resources", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "file_ext"
    t.string "file_mime_type"
    t.string "file_name"
    t.integer "file_size"
    t.string "file_uid"
    t.datetime "updated_at", precision: nil
  end

  create_table "refinery_settings", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.boolean "destroyable", default: true
    t.string "form_value_type"
    t.string "name"
    t.boolean "restricted", default: false
    t.string "scoping"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.text "value"
    t.index ["name"], name: "index_refinery_settings_on_name"
  end

  create_table "refinery_sponsors", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.text "description"
    t.integer "logo_id"
    t.string "name"
    t.integer "position"
    t.integer "sponsorship_level_id"
    t.datetime "updated_at", precision: nil
    t.string "url"
    t.index ["sponsorship_level_id"], name: "index_refinery_sponsors_on_sponsorship_level_id"
  end

  create_table "refinery_sponsors_sponsorship_levels", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "name"
    t.integer "position"
    t.datetime "updated_at", precision: nil
  end

  create_table "refinery_team_members", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "firstname"
    t.string "lastname"
    t.string "linkedin"
    t.string "middlename"
    t.integer "photo_id"
    t.integer "position"
    t.string "role"
    t.boolean "show_on_homepage", default: false
    t.string "twitter"
    t.datetime "updated_at", precision: nil
  end

  create_table "registration_periods", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.date "early_bird_date"
    t.date "end_date"
    t.date "start_date"
    t.datetime "updated_at", precision: nil
  end

  create_table "registrations", id: :serial, force: :cascade do |t|
    t.datetime "arrival", precision: nil
    t.boolean "attended", default: false
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.datetime "departure", precision: nil
    t.text "other_special_needs"
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
    t.boolean "volunteer"
    t.integer "week"
  end

  create_table "registrations_vchoices", id: false, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "vchoice_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "description"
    t.string "name"
    t.integer "resource_id"
    t.string "resource_type"
    t.datetime "updated_at", precision: nil
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "room_locations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "description"
    t.datetime "updated_at", precision: nil
    t.integer "venue_id"
    t.index ["venue_id"], name: "index_room_locations_on_venue_id"
  end

  create_table "rooms", id: :serial, force: :cascade do |t|
    t.date "end_date"
    t.string "guid", null: false
    t.string "name", null: false
    t.integer "room_location_id"
    t.integer "size"
    t.date "start_date"
    t.integer "venue_id", null: false
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "program_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["program_id"], name: "index_schedules_on_program_id"
  end

  create_table "seo_meta", id: :serial, force: :cascade do |t|
    t.string "browser_title"
    t.datetime "created_at", precision: nil, null: false
    t.text "meta_description"
    t.integer "seo_meta_id"
    t.string "seo_meta_type"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["id"], name: "index_seo_meta_on_id"
    t.index ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta"
  end

  create_table "speaker_invitations", id: :serial, force: :cascade do |t|
    t.boolean "accepted", default: false, null: false
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.integer "event_id"
    t.string "token"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["event_id"], name: "index_speaker_invitations_on_event_id"
    t.index ["user_id"], name: "index_speaker_invitations_on_user_id"
  end

  create_table "spina_accounts", id: :serial, force: :cascade do |t|
    t.string "address"
    t.string "city"
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.jsonb "json_attributes"
    t.string "name"
    t.string "phone"
    t.string "postal_code"
    t.text "preferences"
    t.boolean "robots_allowed", default: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_attachment_collections", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_attachment_collections_attachments", id: :serial, force: :cascade do |t|
    t.integer "attachment_collection_id"
    t.integer "attachment_id"
  end

  create_table "spina_attachments", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "file"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_blog_categories", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["slug"], name: "index_spina_blog_categories_on_slug"
  end

  create_table "spina_blog_posts", id: :serial, force: :cascade do |t|
    t.integer "category_id"
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.boolean "draft"
    t.text "excerpt"
    t.boolean "featured", default: false
    t.integer "image_id"
    t.datetime "published_at", precision: nil
    t.string "seo_title"
    t.string "slug"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.integer "user_id"
    t.index ["category_id"], name: "index_spina_blog_posts_on_category_id"
    t.index ["image_id"], name: "index_spina_blog_posts_on_image_id"
    t.index ["slug"], name: "index_spina_blog_posts_on_slug"
    t.index ["user_id"], name: "index_spina_blog_posts_on_user_id"
  end

  create_table "spina_image_collections", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_image_collections_images", id: :serial, force: :cascade do |t|
    t.integer "image_collection_id"
    t.integer "image_id"
    t.integer "position"
    t.index ["image_collection_id"], name: "index_spina_image_collections_images_on_image_collection_id"
    t.index ["image_id"], name: "index_spina_image_collections_images_on_image_id"
  end

  create_table "spina_images", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "media_folder_id"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["media_folder_id"], name: "index_spina_images_on_media_folder_id"
  end

  create_table "spina_layout_parts", id: :serial, force: :cascade do |t|
    t.integer "account_id"
    t.datetime "created_at", precision: nil
    t.integer "layout_partable_id"
    t.string "layout_partable_type"
    t.string "name"
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_line_translations", id: :serial, force: :cascade do |t|
    t.string "content"
    t.datetime "created_at", precision: nil, null: false
    t.string "locale", null: false
    t.integer "spina_line_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_spina_line_translations_on_locale"
    t.index ["spina_line_id"], name: "index_spina_line_translations_on_spina_line_id"
  end

  create_table "spina_lines", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_media_folders", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_navigation_items", id: :serial, force: :cascade do |t|
    t.string "ancestry"
    t.datetime "created_at", precision: nil
    t.string "kind", default: "page", null: false
    t.integer "navigation_id", null: false
    t.integer "page_id"
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", precision: nil
    t.string "url"
    t.string "url_title"
    t.index ["page_id", "navigation_id"], name: "index_spina_navigation_items_on_page_id_and_navigation_id", unique: true
  end

  create_table "spina_navigations", id: :serial, force: :cascade do |t|
    t.boolean "auto_add_pages", default: false, null: false
    t.datetime "created_at", precision: nil
    t.string "label", null: false
    t.string "name", null: false
    t.integer "position", default: 0, null: false
    t.datetime "updated_at", precision: nil
    t.index ["name"], name: "index_spina_navigations_on_name", unique: true
  end

  create_table "spina_options", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.string "value"
  end

  create_table "spina_page_parts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "name"
    t.integer "page_id"
    t.integer "page_partable_id"
    t.string "page_partable_type"
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "spina_page_translations", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "description"
    t.string "locale", null: false
    t.string "materialized_path"
    t.string "menu_title"
    t.string "seo_title"
    t.integer "spina_page_id", null: false
    t.string "title"
    t.datetime "updated_at", precision: nil, null: false
    t.string "url_title"
    t.index ["locale"], name: "index_spina_page_translations_on_locale"
    t.index ["spina_page_id"], name: "index_spina_page_translations_on_spina_page_id"
  end

  create_table "spina_pages", id: :serial, force: :cascade do |t|
    t.boolean "active", default: true
    t.string "ancestry"
    t.integer "ancestry_children_count"
    t.integer "ancestry_depth", default: 0
    t.datetime "created_at", precision: nil, null: false
    t.boolean "deletable", default: true
    t.boolean "draft", default: false
    t.jsonb "json_attributes"
    t.string "layout_template"
    t.string "link_url"
    t.string "name"
    t.integer "position"
    t.integer "resource_id"
    t.boolean "show_in_menu", default: true
    t.boolean "skip_to_first_child", default: false
    t.string "slug"
    t.datetime "updated_at", precision: nil, null: false
    t.string "view_template"
    t.index ["resource_id"], name: "index_spina_pages_on_resource_id"
  end

  create_table "spina_resources", force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "label"
    t.string "name", null: false
    t.string "order_by"
    t.jsonb "slug", default: {}
    t.datetime "updated_at", precision: nil, null: false
    t.string "view_template"
  end

  create_table "spina_rewrite_rules", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "new_path"
    t.string "old_path"
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_settings", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.string "plugin"
    t.jsonb "preferences", default: {}
    t.datetime "updated_at", precision: nil, null: false
    t.index ["plugin"], name: "index_spina_settings_on_plugin"
  end

  create_table "spina_structure_items", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.integer "position"
    t.integer "structure_id"
    t.datetime "updated_at", precision: nil
    t.index ["structure_id"], name: "index_spina_structure_items_on_structure_id"
  end

  create_table "spina_structure_parts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.string "name"
    t.integer "structure_item_id"
    t.integer "structure_partable_id"
    t.string "structure_partable_type"
    t.string "title"
    t.datetime "updated_at", precision: nil
    t.index ["structure_item_id"], name: "index_spina_structure_parts_on_structure_item_id"
    t.index ["structure_partable_id"], name: "index_spina_structure_parts_on_structure_partable_id"
  end

  create_table "spina_structures", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_team_members", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.text "description"
    t.string "firstname", null: false
    t.string "lastname"
    t.string "linkedin"
    t.string "middlename"
    t.bigint "photo_id"
    t.integer "position"
    t.string "role"
    t.boolean "show_on_homepage", default: false
    t.string "twitter"
    t.datetime "updated_at", null: false
    t.index ["photo_id"], name: "index_spina_team_members_on_photo_id"
  end

  create_table "spina_text_translations", id: :serial, force: :cascade do |t|
    t.text "content"
    t.datetime "created_at", precision: nil, null: false
    t.string "locale", null: false
    t.integer "spina_text_id", null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["locale"], name: "index_spina_text_translations_on_locale"
    t.index ["spina_text_id"], name: "index_spina_text_translations_on_spina_text_id"
  end

  create_table "spina_texts", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "spina_users", id: :serial, force: :cascade do |t|
    t.boolean "admin", default: false
    t.datetime "created_at", precision: nil, null: false
    t.string "email"
    t.datetime "last_logged_in", precision: nil
    t.string "name"
    t.string "password_digest"
    t.datetime "password_reset_sent_at", precision: nil
    t.string "password_reset_token"
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "splashpages", id: :serial, force: :cascade do |t|
    t.string "banner_photo_content_type"
    t.string "banner_photo_file_name"
    t.integer "banner_photo_file_size"
    t.datetime "banner_photo_updated_at", precision: nil
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "custom_tags"
    t.boolean "include_activities", default: false
    t.boolean "include_advantages", default: false
    t.boolean "include_cfp", default: false
    t.boolean "include_lodgings"
    t.boolean "include_program"
    t.boolean "include_registrations"
    t.boolean "include_social_media"
    t.boolean "include_sponsors"
    t.boolean "include_tickets"
    t.boolean "include_tracks"
    t.boolean "include_venue"
    t.boolean "public"
    t.datetime "updated_at", precision: nil
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "logo_file_name"
    t.string "name"
    t.string "picture"
    t.string "short_name"
    t.datetime "updated_at", precision: nil
    t.string "website_url"
    t.index ["short_name"], name: "index_sponsors_on_short_name", unique: true
  end

  create_table "sponsors_users", id: false, force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "user_id"
  end

  create_table "sponsorship_infos", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil, null: false
    t.text "description"
    t.string "liaison_email"
    t.string "manual"
    t.string "prospectus"
    t.datetime "updated_at", precision: nil, null: false
    t.index ["conference_id"], name: "index_sponsorship_infos_on_conference_id"
  end

  create_table "sponsorship_levels", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.integer "position"
    t.string "title"
    t.datetime "updated_at", precision: nil
  end

  create_table "sponsorship_levels_benefits", id: :serial, force: :cascade do |t|
    t.integer "benefit_id"
    t.integer "code_type_id"
    t.datetime "created_at", precision: nil
    t.integer "discount"
    t.integer "max_uses"
    t.integer "sponsorship_level_id"
    t.datetime "updated_at", precision: nil
    t.index ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id"
  end

  create_table "sponsorships", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.datetime "created_at", precision: nil
    t.integer "sponsor_id", null: false
    t.integer "sponsorship_level_id"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
  end

  create_table "survey_answers", id: :serial, force: :cascade do |t|
    t.integer "attempt_id"
    t.boolean "correct"
    t.datetime "created_at", precision: nil
    t.integer "option_id"
    t.integer "question_id"
    t.datetime "updated_at", precision: nil
    t.index ["question_id", "option_id"], name: "survey_answers_question_option_id_idx"
  end

  create_table "survey_attempts", id: :serial, force: :cascade do |t|
    t.integer "participant_id"
    t.string "participant_type"
    t.integer "score"
    t.integer "survey_id"
    t.boolean "winner"
  end

  create_table "survey_options", id: :serial, force: :cascade do |t|
    t.boolean "correct"
    t.datetime "created_at", precision: nil
    t.integer "question_id"
    t.string "text"
    t.datetime "updated_at", precision: nil
    t.integer "weight", default: 0
  end

  create_table "survey_questions", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.boolean "imported", default: false
    t.integer "survey_id"
    t.string "text"
    t.datetime "updated_at", precision: nil
  end

  create_table "survey_surveys", id: :serial, force: :cascade do |t|
    t.boolean "active", default: false
    t.integer "attempts_number", default: 0
    t.datetime "created_at", precision: nil
    t.text "description"
    t.boolean "finished", default: false
    t.string "name"
    t.datetime "updated_at", precision: nil
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.string "context"
    t.datetime "created_at", precision: nil
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "targets", id: :serial, force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.date "due_date"
    t.integer "target_count"
    t.string "unit"
    t.datetime "updated_at", precision: nil
  end

  create_table "ticket_group_benefits", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.text "description", null: false
    t.string "name", null: false
    t.integer "position"
    t.integer "ticket_group_id", null: false
    t.datetime "updated_at", precision: nil
  end

  create_table "ticket_group_benefits_tickets", id: false, force: :cascade do |t|
    t.integer "ticket_group_benefit_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_group_benefit_id", "ticket_id"], name: "tg_benefit_tix_idx", unique: true
  end

  create_table "ticket_groups", id: :serial, force: :cascade do |t|
    t.text "additional_details"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.string "description"
    t.string "name"
    t.integer "position"
    t.datetime "updated_at", precision: nil
    t.index ["conference_id"], name: "index_ticket_groups_on_conference_id"
  end

  create_table "ticket_purchases", id: :serial, force: :cascade do |t|
    t.integer "code_id"
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.integer "event_id"
    t.boolean "paid", default: false
    t.integer "payment_id"
    t.string "pending_event_tickets"
    t.integer "purchase_price_cents", default: 0, null: false
    t.string "purchase_price_currency", default: "USD", null: false
    t.integer "quantity", default: 1
    t.integer "ticket_id"
    t.integer "user_id"
    t.index ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id"
    t.index ["event_id"], name: "index_ticket_purchases_on_event_id"
  end

  create_table "ticket_scannings", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil, null: false
    t.integer "physical_ticket_id", null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.text "description"
    t.integer "early_bird_price_cents", default: 0, null: false
    t.string "early_bird_price_currency", default: "USD", null: false
    t.date "end_date"
    t.text "extra_info"
    t.boolean "hidden", default: false
    t.integer "max_per_purchase", default: 10
    t.integer "position"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.string "short_title"
    t.date "start_date"
    t.integer "ticket_group_id"
    t.integer "ticket_type", default: 0
    t.string "title", null: false
    t.index ["ticket_group_id"], name: "index_tickets_on_ticket_group_id"
  end

  create_table "tracks", id: :serial, force: :cascade do |t|
    t.string "color"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "guid", null: false
    t.string "name", null: false
    t.integer "program_id"
    t.datetime "updated_at", precision: nil
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "affiliation"
    t.string "avatar"
    t.string "avatar_content_type"
    t.string "avatar_file_name"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at", precision: nil
    t.text "biography"
    t.string "city"
    t.datetime "confirmation_sent_at", precision: nil
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: nil
    t.string "country"
    t.datetime "created_at", precision: nil
    t.datetime "current_sign_in_at", precision: nil
    t.string "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.boolean "email_public"
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.boolean "guest", default: false
    t.boolean "is_admin", default: false
    t.boolean "is_disabled", default: false
    t.string "languages"
    t.string "last_name"
    t.datetime "last_sign_in_at", precision: nil
    t.string "last_sign_in_ip"
    t.string "mobile"
    t.string "name"
    t.string "nickname"
    t.integer "nickname_type", default: 0
    t.datetime "remember_created_at", precision: nil
    t.datetime "reset_password_sent_at", precision: nil
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0
    t.string "slug"
    t.string "state"
    t.string "title"
    t.string "tshirt"
    t.string "unconfirmed_email"
    t.datetime "updated_at", precision: nil
    t.string "username"
    t.text "volunteer_experience"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug"
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_roles", id: :serial, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "vchoices", id: :serial, force: :cascade do |t|
    t.integer "vday_id"
    t.integer "vposition_id"
  end

  create_table "vdays", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.date "day"
    t.text "description"
    t.datetime "updated_at", precision: nil
  end

  create_table "venues", id: :serial, force: :cascade do |t|
    t.string "city"
    t.integer "conference_id"
    t.string "country"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "guid"
    t.string "latitude"
    t.string "longitude"
    t.string "name"
    t.string "photo_file_name"
    t.string "picture"
    t.string "postalcode"
    t.string "state"
    t.string "street"
    t.datetime "updated_at", precision: nil
    t.string "website"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.string "event", null: false
    t.integer "item_id", null: false
    t.string "item_type", null: false
    t.text "object"
    t.text "object_changes"
    t.string "whodunnit"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.datetime "created_at", precision: nil
    t.integer "event_id"
    t.integer "rating"
    t.datetime "updated_at", precision: nil
    t.integer "user_id"
  end

  create_table "vpositions", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "created_at", precision: nil
    t.text "description"
    t.string "title", null: false
    t.datetime "updated_at", precision: nil
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "advantages", "conferences"
  add_foreign_key "benefit_responses", "benefits"
  add_foreign_key "benefit_responses", "conferences"
  add_foreign_key "benefit_responses", "sponsorships"
  add_foreign_key "benefits", "conferences"
  add_foreign_key "boomset_guests", "conferences"
  add_foreign_key "boomset_guests", "integrations"
  add_foreign_key "boomset_guests", "registrations"
  add_foreign_key "boomset_ticket_configs", "conferences"
  add_foreign_key "boomset_ticket_configs", "integrations"
  add_foreign_key "boomset_ticket_configs", "tickets"
  add_foreign_key "campaigns", "sponsors"
  add_foreign_key "codes", "code_types"
  add_foreign_key "codes", "conferences"
  add_foreign_key "codes", "sponsors"
  add_foreign_key "codes_tickets", "codes"
  add_foreign_key "codes_tickets", "tickets"
  add_foreign_key "conference_team_members", "conferences"
  add_foreign_key "conference_team_members", "spina_team_members", column: "team_member_id", validate: false
  add_foreign_key "conferences", "conference_groups"
  add_foreign_key "conferences_codes", "codes"
  add_foreign_key "conferences_codes", "conferences"
  add_foreign_key "conferences_policies", "conferences"
  add_foreign_key "conferences_policies", "policies"
  add_foreign_key "events", "tickets"
  add_foreign_key "integrations", "conferences"
  add_foreign_key "payment_methods", "conferences"
  add_foreign_key "physical_tickets", "events"
  add_foreign_key "physical_tickets", "registrations"
  add_foreign_key "physical_tickets", "users"
  add_foreign_key "policies", "conferences"
  add_foreign_key "polls", "conferences"
  add_foreign_key "polls", "survey_surveys", column: "survey_id"
  add_foreign_key "refinery_sponsors", "sponsorship_levels"
  add_foreign_key "room_locations", "venues"
  add_foreign_key "rooms", "room_locations"
  add_foreign_key "speaker_invitations", "events"
  add_foreign_key "speaker_invitations", "users"
  add_foreign_key "spina_blog_posts", "spina_images", column: "image_id"
  add_foreign_key "spina_blog_posts", "users"
  add_foreign_key "spina_team_members", "spina_images", column: "photo_id"
  add_foreign_key "sponsors_users", "sponsors"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsorship_infos", "conferences"
  add_foreign_key "sponsorship_levels_benefits", "benefits"
  add_foreign_key "sponsorship_levels_benefits", "sponsorship_levels"
  add_foreign_key "sponsorships", "conferences"
  add_foreign_key "sponsorships", "sponsors"
  add_foreign_key "sponsorships", "sponsorship_levels"
  add_foreign_key "ticket_group_benefits", "ticket_groups"
  add_foreign_key "ticket_group_benefits_tickets", "ticket_group_benefits"
  add_foreign_key "ticket_group_benefits_tickets", "tickets"
  add_foreign_key "ticket_groups", "conferences"
  add_foreign_key "ticket_purchases", "codes"
  add_foreign_key "ticket_purchases", "events"
  add_foreign_key "tickets", "ticket_groups"
end
