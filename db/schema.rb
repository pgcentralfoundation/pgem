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

ActiveRecord::Schema.define(version: 2025_05_27_125010) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"
  enable_extension "tablefunc"
  enable_extension "uuid-ossp"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "picture"
    t.string "website_link"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "picture"
    t.string "website_link"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "advantages", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.string "picture"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ahoy_events", id: :serial, force: :cascade do |t|
    t.integer "visit_id"
    t.integer "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["time"], name: "index_ahoy_events_on_time"
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_events", id: :serial, force: :cascade do |t|
    t.integer "visit_id"
    t.integer "user_id"
    t.string "name"
    t.jsonb "properties"
    t.datetime "time"
    t.index ["name", "time"], name: "index_ahoy_events_on_name_and_time"
    t.index ["time"], name: "index_ahoy_events_on_time"
    t.index ["user_id"], name: "index_ahoy_events_on_user_id"
    t.index ["visit_id"], name: "index_ahoy_events_on_visit_id"
  end

  create_table "ahoy_visits", id: :serial, force: :cascade do |t|
    t.string "visit_token"
    t.string "visitor_token"
    t.integer "user_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.string "referring_domain"
    t.text "landing_page"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.decimal "latitude", precision: 10, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.string "app_version"
    t.string "os_version"
    t.string "platform"
    t.datetime "started_at"
    t.index ["visit_token"], name: "index_ahoy_visits_on_visit_token", unique: true
  end

  create_table "alchemy_attachments", force: :cascade do |t|
    t.string "name"
    t.string "file_name"
    t.string "file_mime_type"
    t.integer "file_size"
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "file_uid"
    t.index ["creator_id"], name: "index_alchemy_attachments_on_creator_id"
    t.index ["file_uid"], name: "index_alchemy_attachments_on_file_uid"
    t.index ["updater_id"], name: "index_alchemy_attachments_on_updater_id"
  end

  create_table "alchemy_contents", force: :cascade do |t|
    t.string "name"
    t.string "essence_type", null: false
    t.bigint "essence_id", null: false
    t.bigint "element_id", null: false
    t.index ["element_id"], name: "index_alchemy_contents_on_element_id"
    t.index ["essence_type", "essence_id"], name: "index_alchemy_contents_on_essence_type_and_essence_id", unique: true
  end

  create_table "alchemy_elements", force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.boolean "public", default: true, null: false
    t.boolean "folded", default: false, null: false
    t.boolean "unique", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.bigint "parent_element_id"
    t.boolean "fixed", default: false, null: false
    t.bigint "page_version_id", null: false
    t.index ["creator_id"], name: "index_alchemy_elements_on_creator_id"
    t.index ["fixed"], name: "index_alchemy_elements_on_fixed"
    t.index ["page_version_id", "parent_element_id"], name: "idx_alchemy_elements_on_page_version_id_and_parent_element_id"
    t.index ["page_version_id", "position"], name: "idx_alchemy_elements_on_page_version_id_and_position"
    t.index ["updater_id"], name: "index_alchemy_elements_on_updater_id"
  end

  create_table "alchemy_elements_alchemy_pages", id: false, force: :cascade do |t|
    t.bigint "element_id"
    t.bigint "page_id"
    t.index ["element_id"], name: "index_alchemy_elements_alchemy_pages_on_element_id"
    t.index ["page_id"], name: "index_alchemy_elements_alchemy_pages_on_page_id"
  end

  create_table "alchemy_essence_audios", force: :cascade do |t|
    t.bigint "attachment_id"
    t.boolean "controls", default: true, null: false
    t.boolean "autoplay", default: false
    t.boolean "loop", default: false, null: false
    t.boolean "muted", default: false, null: false
    t.index ["attachment_id"], name: "index_alchemy_essence_audios_on_attachment_id"
  end

  create_table "alchemy_essence_booleans", force: :cascade do |t|
    t.boolean "value"
    t.index ["value"], name: "index_alchemy_essence_booleans_on_value"
  end

  create_table "alchemy_essence_dates", force: :cascade do |t|
    t.datetime "date"
  end

  create_table "alchemy_essence_files", force: :cascade do |t|
    t.bigint "attachment_id"
    t.string "title"
    t.string "css_class"
    t.string "link_text"
    t.index ["attachment_id"], name: "index_alchemy_essence_files_on_attachment_id"
  end

  create_table "alchemy_essence_headlines", force: :cascade do |t|
    t.text "body"
    t.integer "level"
    t.integer "size"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "alchemy_essence_htmls", force: :cascade do |t|
    t.text "source"
  end

  create_table "alchemy_essence_links", force: :cascade do |t|
    t.string "link"
    t.string "link_title"
    t.string "link_target"
    t.string "link_class_name"
  end

  create_table "alchemy_essence_nodes", force: :cascade do |t|
    t.bigint "node_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["node_id"], name: "index_alchemy_essence_nodes_on_node_id"
  end

  create_table "alchemy_essence_pages", force: :cascade do |t|
    t.bigint "page_id"
    t.index ["page_id"], name: "index_alchemy_essence_pages_on_page_id"
  end

  create_table "alchemy_essence_pictures", force: :cascade do |t|
    t.bigint "picture_id"
    t.string "caption"
    t.string "title"
    t.string "alt_tag"
    t.string "link"
    t.string "link_class_name"
    t.string "link_title"
    t.string "css_class"
    t.string "link_target"
    t.string "crop_from"
    t.string "crop_size"
    t.string "render_size"
    t.index ["picture_id"], name: "index_alchemy_essence_pictures_on_picture_id"
  end

  create_table "alchemy_essence_richtexts", force: :cascade do |t|
    t.text "body"
    t.text "stripped_body"
    t.boolean "public", default: false, null: false
    t.text "sanitized_body"
  end

  create_table "alchemy_essence_selects", force: :cascade do |t|
    t.string "value"
    t.index ["value"], name: "index_alchemy_essence_selects_on_value"
  end

  create_table "alchemy_essence_texts", force: :cascade do |t|
    t.text "body"
    t.string "link"
    t.string "link_title"
    t.string "link_class_name"
    t.boolean "public", default: false, null: false
    t.string "link_target"
  end

  create_table "alchemy_essence_videos", force: :cascade do |t|
    t.bigint "attachment_id"
    t.string "width"
    t.string "height"
    t.boolean "allow_fullscreen", default: true, null: false
    t.boolean "autoplay", default: false, null: false
    t.boolean "controls", default: true, null: false
    t.boolean "loop", default: false, null: false
    t.boolean "muted", default: false, null: false
    t.string "preload"
    t.boolean "playsinline", default: false, null: false
    t.index ["attachment_id"], name: "index_alchemy_essence_videos_on_attachment_id"
  end

  create_table "alchemy_folded_pages", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.bigint "user_id", null: false
    t.boolean "folded", default: false, null: false
    t.index ["page_id", "user_id"], name: "index_alchemy_folded_pages_on_page_id_and_user_id", unique: true
  end

  create_table "alchemy_ingredients", force: :cascade do |t|
    t.bigint "element_id", null: false
    t.string "type", null: false
    t.string "role", null: false
    t.text "value"
    t.jsonb "data", default: {}
    t.string "related_object_type"
    t.bigint "related_object_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["element_id", "role"], name: "index_alchemy_ingredients_on_element_id_and_role", unique: true
    t.index ["element_id"], name: "index_alchemy_ingredients_on_element_id"
    t.index ["related_object_id", "related_object_type"], name: "idx_alchemy_ingredient_relation"
    t.index ["type"], name: "index_alchemy_ingredients_on_type"
  end

  create_table "alchemy_languages", force: :cascade do |t|
    t.string "name"
    t.string "language_code"
    t.string "frontpage_name"
    t.string "page_layout", default: "intro"
    t.boolean "public", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.boolean "default", default: false, null: false
    t.string "country_code", default: "", null: false
    t.bigint "site_id", null: false
    t.string "locale"
    t.index ["creator_id"], name: "index_alchemy_languages_on_creator_id"
    t.index ["language_code", "country_code"], name: "index_alchemy_languages_on_language_code_and_country_code"
    t.index ["language_code"], name: "index_alchemy_languages_on_language_code"
    t.index ["site_id"], name: "index_alchemy_languages_on_site_id"
    t.index ["updater_id"], name: "index_alchemy_languages_on_updater_id"
  end

  create_table "alchemy_legacy_page_urls", force: :cascade do |t|
    t.string "urlname", null: false
    t.bigint "page_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_alchemy_legacy_page_urls_on_page_id"
    t.index ["urlname"], name: "index_alchemy_legacy_page_urls_on_urlname"
  end

  create_table "alchemy_nodes", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.string "url"
    t.boolean "nofollow", default: false, null: false
    t.boolean "external", default: false, null: false
    t.boolean "folded", default: false, null: false
    t.bigint "parent_id"
    t.integer "lft", null: false
    t.integer "rgt", null: false
    t.integer "depth", default: 0, null: false
    t.bigint "page_id"
    t.bigint "language_id", null: false
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "menu_type", null: false
    t.index ["creator_id"], name: "index_alchemy_nodes_on_creator_id"
    t.index ["language_id"], name: "index_alchemy_nodes_on_language_id"
    t.index ["lft"], name: "index_alchemy_nodes_on_lft"
    t.index ["page_id"], name: "index_alchemy_nodes_on_page_id"
    t.index ["parent_id"], name: "index_alchemy_nodes_on_parent_id"
    t.index ["rgt"], name: "index_alchemy_nodes_on_rgt"
    t.index ["updater_id"], name: "index_alchemy_nodes_on_updater_id"
  end

  create_table "alchemy_page_versions", force: :cascade do |t|
    t.bigint "page_id", null: false
    t.datetime "public_on"
    t.datetime "public_until"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["page_id"], name: "index_alchemy_page_versions_on_page_id"
    t.index ["public_on", "public_until"], name: "index_alchemy_page_versions_on_public_on_and_public_until"
  end

  create_table "alchemy_pages", force: :cascade do |t|
    t.string "name"
    t.string "urlname"
    t.string "title"
    t.string "language_code"
    t.boolean "language_root", default: false, null: false
    t.string "page_layout"
    t.text "meta_keywords"
    t.text "meta_description"
    t.integer "lft"
    t.integer "rgt"
    t.bigint "parent_id"
    t.integer "depth"
    t.integer "locked_by"
    t.boolean "restricted", default: false, null: false
    t.boolean "robot_index", default: true, null: false
    t.boolean "robot_follow", default: true, null: false
    t.boolean "sitemap", default: true, null: false
    t.boolean "layoutpage", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.bigint "language_id", null: false
    t.datetime "published_at"
    t.datetime "legacy_public_on"
    t.datetime "legacy_public_until"
    t.datetime "locked_at"
    t.boolean "searchable", default: true, null: false
    t.index ["creator_id"], name: "index_alchemy_pages_on_creator_id"
    t.index ["language_id"], name: "index_alchemy_pages_on_language_id"
    t.index ["locked_at", "locked_by"], name: "index_alchemy_pages_on_locked_at_and_locked_by"
    t.index ["parent_id", "lft"], name: "index_pages_on_parent_id_and_lft"
    t.index ["rgt"], name: "index_alchemy_pages_on_rgt"
    t.index ["updater_id"], name: "index_alchemy_pages_on_updater_id"
    t.index ["urlname"], name: "index_pages_on_urlname"
  end

  create_table "alchemy_picture_thumbs", force: :cascade do |t|
    t.bigint "picture_id", null: false
    t.string "signature", null: false
    t.text "uid", null: false
    t.index ["picture_id"], name: "index_alchemy_picture_thumbs_on_picture_id"
    t.index ["signature"], name: "index_alchemy_picture_thumbs_on_signature", unique: true
  end

  create_table "alchemy_pictures", force: :cascade do |t|
    t.string "name"
    t.string "image_file_name"
    t.integer "image_file_width"
    t.integer "image_file_height"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "creator_id"
    t.bigint "updater_id"
    t.string "upload_hash"
    t.string "image_file_uid"
    t.integer "image_file_size"
    t.string "image_file_format"
    t.index ["creator_id"], name: "index_alchemy_pictures_on_creator_id"
    t.index ["updater_id"], name: "index_alchemy_pictures_on_updater_id"
  end

  create_table "alchemy_sites", force: :cascade do |t|
    t.string "host"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "public", default: false, null: false
    t.text "aliases"
    t.boolean "redirect_to_primary_host", default: false, null: false
    t.index ["host", "public"], name: "alchemy_sites_public_hosts_idx"
    t.index ["host"], name: "index_alchemy_sites_on_host"
  end

  create_table "alchemy_users", id: :serial, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "login"
    t.string "email"
    t.string "language"
    t.string "encrypted_password", limit: 128, default: "", null: false
    t.string "password_salt", limit: 128, default: "", null: false
    t.integer "sign_in_count", default: 0, null: false
    t.integer "failed_attempts", default: 0, null: false
    t.datetime "last_request_at"
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "creator_id"
    t.integer "updater_id"
    t.text "cached_tag_list"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.string "alchemy_roles", default: "member"
    t.index ["alchemy_roles"], name: "index_alchemy_users_on_alchemy_roles"
    t.index ["email"], name: "index_alchemy_users_on_email", unique: true
    t.index ["login"], name: "index_alchemy_users_on_login", unique: true
    t.index ["reset_password_token"], name: "index_alchemy_users_on_reset_password_token", unique: true
  end

  create_table "answers", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "benefit_responses", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "sponsorship_id"
    t.integer "benefit_id"
    t.text "text_response"
    t.string "file_response"
    t.boolean "bool_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true
    t.index ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true
  end

  create_table "benefit_responses", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "sponsorship_id"
    t.integer "benefit_id"
    t.text "text_response"
    t.string "file_response"
    t.boolean "bool_response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true
    t.index ["conference_id", "sponsorship_id", "benefit_id"], name: "conf_sponsorship_benefit_idx", unique: true
  end

  create_table "benefits", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "conference_id"
    t.integer "category"
    t.integer "value_type"
    t.text "description"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id"], name: "index_benefits_on_conference_id"
    t.index ["conference_id"], name: "index_benefits_on_conference_id"
  end

  create_table "benefits", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "conference_id"
    t.integer "category"
    t.integer "value_type"
    t.text "description"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id"], name: "index_benefits_on_conference_id"
    t.index ["conference_id"], name: "index_benefits_on_conference_id"
  end

  create_table "boomset_guests", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "integration_id"
    t.integer "registration_id"
    t.integer "boomset_guest"
    t.string "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "boomset_guest"], name: "index_boomset_guests_on_conference_id_and_boomset_guest"
    t.index ["conference_id", "registration_id"], name: "index_boomset_guests_on_conference_id_and_registration_id", unique: true
    t.index ["conference_id", "token"], name: "index_boomset_guests_on_conference_id_and_token"
  end

  create_table "boomset_ticket_configs", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "integration_id"
    t.integer "ticket_id"
    t.integer "boomset_registration_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "ticket_id", "integration_id"], name: "bs_conf_tix_int_idx", unique: true
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "name"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sponsor_id"
    t.text "description"
    t.date "started_at"
    t.index ["sponsor_id"], name: "index_campaigns_on_sponsor_id"
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "name"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sponsor_id"
    t.text "description"
    t.date "started_at"
    t.index ["sponsor_id"], name: "index_campaigns_on_sponsor_id"
  end

  create_table "cfps", id: :serial, force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "program_id"
    t.date "reg_reminder_end"
    t.date "notification_deadline"
  end

  create_table "cfps", id: :serial, force: :cascade do |t|
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "program_id"
    t.date "reg_reminder_end"
    t.date "notification_deadline"
  end

  create_table "code_types", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["title"], name: "index_code_types_on_title", unique: true
    t.index ["title"], name: "index_code_types_on_title", unique: true
  end

  create_table "code_types", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["title"], name: "index_code_types_on_title", unique: true
    t.index ["title"], name: "index_code_types_on_title", unique: true
  end

  create_table "codes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "code_type_id"
    t.integer "conference_id"
    t.integer "discount"
    t.integer "max_uses", default: 0, null: false
    t.integer "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "name"], name: "index_codes_on_conference_id_and_name", unique: true
    t.index ["conference_id"], name: "index_codes_on_conference_id"
    t.index ["name"], name: "index_codes_on_name", unique: true
    t.index ["sponsor_id"], name: "index_codes_on_sponsor_id"
    t.index ["sponsor_id"], name: "index_codes_on_sponsor_id"
  end

  create_table "codes", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "code_type_id"
    t.integer "conference_id"
    t.integer "discount"
    t.integer "max_uses", default: 0, null: false
    t.integer "sponsor_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "name"], name: "index_codes_on_conference_id_and_name", unique: true
    t.index ["conference_id"], name: "index_codes_on_conference_id"
    t.index ["name"], name: "index_codes_on_name", unique: true
    t.index ["sponsor_id"], name: "index_codes_on_sponsor_id"
    t.index ["sponsor_id"], name: "index_codes_on_sponsor_id"
  end

  create_table "codes_tickets", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "ticket_id"
    t.index ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true
    t.index ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true
  end

  create_table "codes_tickets", id: false, force: :cascade do |t|
    t.integer "code_id"
    t.integer "ticket_id"
    t.index ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true
    t.index ["code_id", "ticket_id"], name: "index_codes_tickets_on_code_id_and_ticket_id", unique: true
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "title", limit: 50, default: ""
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "subject"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "title", limit: 50, default: ""
    t.text "body"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "subject"
    t.integer "parent_id"
    t.integer "lft"
    t.integer "rgt"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_id"], name: "index_comments_on_commentable_id"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["commentable_type"], name: "index_comments_on_commentable_type"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "commercials", id: :serial, force: :cascade do |t|
    t.string "commercial_id"
    t.string "commercial_type"
    t.integer "commercialable_id"
    t.string "commercialable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url"
  end

  create_table "commercials", id: :serial, force: :cascade do |t|
    t.string "commercial_id"
    t.string "commercial_type"
    t.integer "commercialable_id"
    t.string "commercialable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "url"
  end

  create_table "conference_groups", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "conference_team_members", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.integer "refinery_team_member_id", null: false
    t.integer "position", null: false
    t.index ["conference_id"], name: "index_conference_team_members_on_conference_id"
  end

  create_table "conferences", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.string "title", null: false
    t.string "short_title", null: false
    t.string "timezone", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.integer "revision"
    t.boolean "use_vpositions", default: false
    t.boolean "use_vdays", default: false
    t.boolean "use_volunteers"
    t.string "color"
    t.text "events_per_week"
    t.text "description"
    t.integer "registration_limit", default: 0
    t.string "picture"
    t.integer "start_hour", default: 9
    t.integer "end_hour", default: 20
    t.boolean "require_itinerary"
    t.boolean "use_pg_flow", default: true
    t.string "background_file_name"
    t.string "default_currency", default: "USD"
    t.string "braintree_merchant_account"
    t.integer "ticket_layout", default: 0
    t.text "extended_description"
    t.integer "conference_group_id"
    t.boolean "sticky", default: false
    t.boolean "digital"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_conferences_on_deleted_at"
  end

  create_table "conferences", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.string "title", null: false
    t.string "short_title", null: false
    t.string "timezone", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.integer "revision"
    t.boolean "use_vpositions", default: false
    t.boolean "use_vdays", default: false
    t.boolean "use_volunteers"
    t.string "color"
    t.text "events_per_week"
    t.text "description"
    t.integer "registration_limit", default: 0
    t.string "picture"
    t.integer "start_hour", default: 9
    t.integer "end_hour", default: 20
    t.boolean "require_itinerary"
    t.boolean "use_pg_flow", default: true
    t.string "background_file_name"
    t.string "default_currency", default: "USD"
    t.string "braintree_merchant_account"
    t.integer "ticket_layout", default: 0
    t.text "extended_description"
    t.integer "conference_group_id"
    t.boolean "sticky", default: false
    t.boolean "digital"
    t.datetime "deleted_at"
    t.index ["deleted_at"], name: "index_conferences_on_deleted_at"
  end

  create_table "conferences_codes", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "code_id"
    t.index ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true
    t.index ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true
  end

  create_table "conferences_codes", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "code_id"
    t.index ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true
    t.index ["conference_id", "code_id"], name: "index_conferences_codes_on_conference_id_and_code_id", unique: true
  end

  create_table "conferences_doh", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('conferences_id_seq'::regclass)" }, null: false
    t.string "guid", null: false
    t.string "title", null: false
    t.string "short_title", null: false
    t.string "timezone", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.integer "revision"
    t.boolean "use_vpositions", default: false
    t.boolean "use_vdays", default: false
    t.boolean "use_volunteers"
    t.string "color"
    t.text "events_per_week"
    t.text "description"
    t.integer "registration_limit", default: 0
    t.string "picture"
    t.integer "start_hour", default: 9
    t.integer "end_hour", default: 20
    t.boolean "require_itinerary"
    t.boolean "use_pg_flow", default: true
    t.string "background_file_name"
    t.string "default_currency", default: "USD"
    t.string "braintree_merchant_account"
    t.integer "ticket_layout", default: 0
    t.text "extended_description"
    t.integer "conference_group_id"
    t.string "tile_background_file_name"
    t.string "tile_font_color", default: "#ffffff"
  end

  create_table "conferences_doh_2", id: false, force: :cascade do |t|
    t.integer "id", default: -> { "nextval('conferences_id_seq'::regclass)" }, null: false
    t.string "guid", null: false
    t.string "title", null: false
    t.string "short_title", null: false
    t.string "timezone", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "logo_file_name"
    t.integer "revision"
    t.boolean "use_vpositions", default: false
    t.boolean "use_vdays", default: false
    t.boolean "use_volunteers"
    t.string "color"
    t.text "events_per_week"
    t.text "description"
    t.integer "registration_limit", default: 0
    t.string "picture"
    t.integer "start_hour", default: 9
    t.integer "end_hour", default: 20
    t.boolean "require_itinerary"
    t.boolean "use_pg_flow", default: true
    t.string "background_file_name"
    t.string "default_currency", default: "USD"
    t.string "braintree_merchant_account"
    t.integer "ticket_layout", default: 0
    t.text "extended_description"
    t.integer "conference_group_id"
    t.string "tile_background_file_name"
    t.string "tile_font_color", default: "#ffffff"
  end

  create_table "conferences_policies", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "policy_id"
    t.index ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true
    t.index ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true
  end

  create_table "conferences_policies", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "policy_id"
    t.index ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true
    t.index ["conference_id", "policy_id"], name: "index_conferences_policies_on_conference_id_and_policy_id", unique: true
  end

  create_table "conferences_questions", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "question_id"
  end

  create_table "conferences_questions", id: false, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "question_id"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "social_tag"
    t.string "email"
    t.string "facebook"
    t.string "googleplus"
    t.string "twitter"
    t.string "instagram"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sponsor_email"
    t.string "name"
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
  end

  create_table "contacts", id: :serial, force: :cascade do |t|
    t.string "social_tag"
    t.string "email"
    t.string "facebook"
    t.string "googleplus"
    t.string "twitter"
    t.string "instagram"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "sponsor_email"
    t.string "name"
    t.string "street1"
    t.string "street2"
    t.string "city"
    t.string "state"
    t.string "country"
    t.string "postal_code"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "delayed_jobs", id: :serial, force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "difficulty_levels", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "program_id"
  end

  create_table "difficulty_levels", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "program_id"
  end

  create_table "email_settings", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.boolean "send_on_registration", default: false
    t.boolean "send_on_accepted", default: false
    t.boolean "send_on_rejected", default: false
    t.boolean "send_on_confirmed_without_registration", default: false
    t.text "registration_body"
    t.text "accepted_body"
    t.text "rejected_body"
    t.text "confirmed_without_registration_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "registration_subject"
    t.string "accepted_subject"
    t.string "rejected_subject"
    t.string "confirmed_without_registration_subject"
    t.boolean "send_on_conference_dates_updated", default: false
    t.string "conference_dates_updated_subject"
    t.text "conference_dates_updated_body"
    t.boolean "send_on_conference_registration_dates_updated", default: false
    t.string "conference_registration_dates_updated_subject"
    t.text "conference_registration_dates_updated_body"
    t.boolean "send_on_venue_updated", default: false
    t.string "venue_updated_subject"
    t.text "venue_updated_body"
    t.boolean "send_on_cfp_dates_updated", default: false
    t.boolean "send_on_program_schedule_public", default: false
    t.string "program_schedule_public_subject"
    t.string "cfp_dates_updated_subject"
    t.text "program_schedule_public_body"
    t.text "cfp_dates_updated_body"
    t.string "purchase_confirmation_subject"
    t.text "purchase_confirmation_body"
    t.string "ticket_confirmation_subject"
    t.text "ticket_confirmation_body"
    t.string "assign_ticket_subject"
    t.text "assign_ticket_body"
    t.string "pending_assign_ticket_subject"
    t.text "pending_assign_ticket_body"
    t.boolean "send_ticket_pdf", default: true
  end

  create_table "email_settings", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.boolean "send_on_registration", default: false
    t.boolean "send_on_accepted", default: false
    t.boolean "send_on_rejected", default: false
    t.boolean "send_on_confirmed_without_registration", default: false
    t.text "registration_body"
    t.text "accepted_body"
    t.text "rejected_body"
    t.text "confirmed_without_registration_body"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "registration_subject"
    t.string "accepted_subject"
    t.string "rejected_subject"
    t.string "confirmed_without_registration_subject"
    t.boolean "send_on_conference_dates_updated", default: false
    t.string "conference_dates_updated_subject"
    t.text "conference_dates_updated_body"
    t.boolean "send_on_conference_registration_dates_updated", default: false
    t.string "conference_registration_dates_updated_subject"
    t.text "conference_registration_dates_updated_body"
    t.boolean "send_on_venue_updated", default: false
    t.string "venue_updated_subject"
    t.text "venue_updated_body"
    t.boolean "send_on_cfp_dates_updated", default: false
    t.boolean "send_on_program_schedule_public", default: false
    t.string "program_schedule_public_subject"
    t.string "cfp_dates_updated_subject"
    t.text "program_schedule_public_body"
    t.text "cfp_dates_updated_body"
    t.string "purchase_confirmation_subject"
    t.text "purchase_confirmation_body"
    t.string "ticket_confirmation_subject"
    t.text "ticket_confirmation_body"
    t.string "assign_ticket_subject"
    t.text "assign_ticket_body"
    t.string "pending_assign_ticket_subject"
    t.text "pending_assign_ticket_body"
    t.boolean "send_ticket_pdf", default: true
  end

  create_table "event_schedules", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "schedule_id"
    t.integer "room_id"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true
    t.index ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
    t.index ["room_id"], name: "index_event_schedules_on_room_id"
    t.index ["room_id"], name: "index_event_schedules_on_room_id"
    t.index ["schedule_id"], name: "index_event_schedules_on_schedule_id"
    t.index ["schedule_id"], name: "index_event_schedules_on_schedule_id"
  end

  create_table "event_schedules", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "schedule_id"
    t.integer "room_id"
    t.datetime "start_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true
    t.index ["event_id", "schedule_id"], name: "index_event_schedules_on_event_id_and_schedule_id", unique: true
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
    t.index ["event_id"], name: "index_event_schedules_on_event_id"
    t.index ["room_id"], name: "index_event_schedules_on_room_id"
    t.index ["room_id"], name: "index_event_schedules_on_room_id"
    t.index ["schedule_id"], name: "index_event_schedules_on_schedule_id"
    t.index ["schedule_id"], name: "index_event_schedules_on_schedule_id"
  end

  create_table "event_schedules_bak", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "event_id"
    t.integer "schedule_id"
    t.integer "room_id"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_schedules_load", id: false, force: :cascade do |t|
    t.integer "id"
    t.integer "event_id"
    t.integer "schedule_id"
    t.integer "room_id"
    t.datetime "start_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "event_types", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.integer "length", default: 30
    t.integer "minimum_abstract_length", default: 0
    t.integer "maximum_abstract_length", default: 500
    t.string "color"
    t.string "description"
    t.integer "program_id"
    t.boolean "internal_event", default: false
  end

  create_table "event_types", id: :serial, force: :cascade do |t|
    t.string "title", null: false
    t.integer "length", default: 30
    t.integer "minimum_abstract_length", default: 0
    t.integer "maximum_abstract_length", default: 500
    t.string "color"
    t.string "description"
    t.integer "program_id"
    t.boolean "internal_event", default: false
  end

  create_table "event_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.string "event_role", default: "participant", null: false
    t.string "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_highlight", default: false
  end

  create_table "event_users", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "event_id"
    t.string "event_role", default: "participant", null: false
    t.string "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "is_highlight", default: false
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.integer "event_type_id"
    t.string "title", null: false
    t.string "subtitle"
    t.string "state", default: "new", null: false
    t.string "progress", default: "new", null: false
    t.string "language"
    t.datetime "start_time"
    t.text "abstract"
    t.text "description"
    t.boolean "public", default: true
    t.text "proposal_additional_speakers"
    t.integer "track_id"
    t.integer "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "require_registration"
    t.integer "difficulty_level_id"
    t.integer "week"
    t.boolean "is_highlight", default: false
    t.integer "program_id"
    t.integer "max_attendees"
    t.string "slug"
    t.integer "ticket_id"
    t.string "document"
    t.boolean "speakers_pending"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["ticket_id"], name: "index_events_on_ticket_id"
    t.index ["ticket_id"], name: "index_events_on_ticket_id"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.integer "event_type_id"
    t.string "title", null: false
    t.string "subtitle"
    t.string "state", default: "new", null: false
    t.string "progress", default: "new", null: false
    t.string "language"
    t.datetime "start_time"
    t.text "abstract"
    t.text "description"
    t.boolean "public", default: true
    t.text "proposal_additional_speakers"
    t.integer "track_id"
    t.integer "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "require_registration"
    t.integer "difficulty_level_id"
    t.integer "week"
    t.boolean "is_highlight", default: false
    t.integer "program_id"
    t.integer "max_attendees"
    t.string "slug"
    t.integer "ticket_id"
    t.string "document"
    t.boolean "speakers_pending"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["slug"], name: "index_events_on_slug"
    t.index ["ticket_id"], name: "index_events_on_ticket_id"
    t.index ["ticket_id"], name: "index_events_on_ticket_id"
  end

  create_table "events_back", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "guid"
    t.integer "event_type_id"
    t.string "title"
    t.string "subtitle"
    t.string "state"
    t.string "progress"
    t.string "language"
    t.datetime "start_time"
    t.text "abstract"
    t.text "description"
    t.boolean "public"
    t.text "proposal_additional_speakers"
    t.integer "track_id"
    t.integer "room_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "require_registration"
    t.integer "difficulty_level_id"
    t.integer "week"
    t.boolean "is_highlight"
    t.integer "program_id"
    t.integer "max_attendees"
  end

  create_table "events_registrations", id: :serial, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "event_id"
    t.boolean "attended", default: false, null: false
    t.datetime "created_at"
  end

  create_table "events_registrations", id: :serial, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "event_id"
    t.boolean "attended", default: false, null: false
    t.datetime "created_at"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "friendly_id_slugs", id: :serial, force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "gutentag_taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id", null: false
    t.integer "taggable_id", null: false
    t.string "taggable_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["tag_id"], name: "index_gutentag_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id", "tag_id"], name: "unique_taggings", unique: true
    t.index ["taggable_type", "taggable_id"], name: "index_gutentag_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "gutentag_tags", id: :serial, force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "taggings_count", default: 0, null: false
    t.index ["name"], name: "index_gutentag_tags_on_name", unique: true
    t.index ["taggings_count"], name: "index_gutentag_tags_on_taggings_count"
  end

  create_table "integrations", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "integration_type"
    t.string "key"
    t.string "url"
    t.string "integration_config_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "integration_type"], name: "index_integrations_on_conference_id_and_integration_type", unique: true
  end

  create_table "lodgings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "website_link"
    t.integer "conference_id"
    t.string "picture"
  end

  create_table "lodgings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "photo_file_name"
    t.string "photo_content_type"
    t.integer "photo_file_size"
    t.datetime "photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "website_link"
    t.integer "conference_id"
    t.string "picture"
  end

  create_table "openids", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "email"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "openids", id: :serial, force: :cascade do |t|
    t.string "provider"
    t.string "email"
    t.string "uid"
    t.integer "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payment_methods", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.string "environment", null: false
    t.string "gateway", null: false
    t.string "braintree_environment"
    t.string "braintree_merchant_id"
    t.string "braintree_public_key"
    t.string "braintree_private_key"
    t.string "braintree_merchant_account"
    t.string "payu_store_name"
    t.string "payu_store_id"
    t.string "payu_webservice_name"
    t.string "payu_webservice_password"
    t.string "payu_signature_key"
    t.string "payu_service_domain"
    t.string "stripe_publishable_key"
    t.string "stripe_secret_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "environment"], name: "index_payment_methods_on_conference_id_and_environment", unique: true
    t.index ["conference_id", "environment"], name: "index_payment_methods_on_conference_id_and_environment", unique: true
  end

  create_table "payment_methods", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.string "environment", null: false
    t.string "gateway", null: false
    t.string "braintree_environment"
    t.string "braintree_merchant_id"
    t.string "braintree_public_key"
    t.string "braintree_private_key"
    t.string "braintree_merchant_account"
    t.string "payu_store_name"
    t.string "payu_store_id"
    t.string "payu_webservice_name"
    t.string "payu_webservice_password"
    t.string "payu_signature_key"
    t.string "payu_service_domain"
    t.string "stripe_publishable_key"
    t.string "stripe_secret_key"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "environment"], name: "index_payment_methods_on_conference_id_and_environment", unique: true
    t.index ["conference_id", "environment"], name: "index_payment_methods_on_conference_id_and_environment", unique: true
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.string "last4"
    t.integer "amount"
    t.string "authorization_code"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.integer "conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.index ["reference"], name: "index_payments_on_reference", unique: true
    t.index ["reference"], name: "index_payments_on_reference", unique: true
  end

  create_table "payments", id: :serial, force: :cascade do |t|
    t.string "last4"
    t.integer "amount"
    t.string "authorization_code"
    t.integer "status", default: 0, null: false
    t.integer "user_id", null: false
    t.integer "conference_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reference"
    t.index ["reference"], name: "index_payments_on_reference", unique: true
    t.index ["reference"], name: "index_payments_on_reference", unique: true
  end

  create_table "physical_tickets", id: :serial, force: :cascade do |t|
    t.integer "ticket_purchase_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.integer "user_id", null: false
    t.integer "event_id"
    t.integer "registration_id", null: false
    t.string "pending_assignment"
    t.index "lower((pending_assignment)::text)", name: "pending_ticket_assignment_idx", where: "(pending_assignment IS NOT NULL)"
    t.index "lower((pending_assignment)::text)", name: "pending_ticket_assignment_idx", where: "(pending_assignment IS NOT NULL)"
    t.index ["registration_id"], name: "index_physical_tickets_on_registration_id"
    t.index ["registration_id"], name: "index_physical_tickets_on_registration_id"
    t.index ["token"], name: "index_physical_tickets_on_token", unique: true
    t.index ["token"], name: "index_physical_tickets_on_token", unique: true
    t.index ["user_id"], name: "index_physical_tickets_on_user_id"
    t.index ["user_id"], name: "index_physical_tickets_on_user_id"
  end

  create_table "physical_tickets", id: :serial, force: :cascade do |t|
    t.integer "ticket_purchase_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "token"
    t.integer "user_id", null: false
    t.integer "event_id"
    t.integer "registration_id", null: false
    t.string "pending_assignment"
    t.index "lower((pending_assignment)::text)", name: "pending_ticket_assignment_idx", where: "(pending_assignment IS NOT NULL)"
    t.index "lower((pending_assignment)::text)", name: "pending_ticket_assignment_idx", where: "(pending_assignment IS NOT NULL)"
    t.index ["registration_id"], name: "index_physical_tickets_on_registration_id"
    t.index ["registration_id"], name: "index_physical_tickets_on_registration_id"
    t.index ["token"], name: "index_physical_tickets_on_token", unique: true
    t.index ["token"], name: "index_physical_tickets_on_token", unique: true
    t.index ["user_id"], name: "index_physical_tickets_on_user_id"
    t.index ["user_id"], name: "index_physical_tickets_on_user_id"
  end

  create_table "policies", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "conference_id"
    t.boolean "global"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "policies", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "conference_id"
    t.boolean "global"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "polls", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "survey_id"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id"], name: "index_polls_on_conference_id"
    t.index ["conference_id"], name: "index_polls_on_conference_id"
  end

  create_table "polls", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "survey_id"
    t.text "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id"], name: "index_polls_on_conference_id"
    t.index ["conference_id"], name: "index_polls_on_conference_id"
  end

  create_table "programs", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "rating", default: 0
    t.boolean "schedule_public", default: false
    t.boolean "schedule_fluid", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "languages"
    t.boolean "blind_voting", default: false
    t.datetime "voting_start_date"
    t.datetime "voting_end_date"
    t.integer "selected_schedule_id"
    t.index ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id"
    t.index ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id"
  end

  create_table "programs", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "rating", default: 0
    t.boolean "schedule_public", default: false
    t.boolean "schedule_fluid", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "languages"
    t.boolean "blind_voting", default: false
    t.datetime "voting_start_date"
    t.datetime "voting_end_date"
    t.integer "selected_schedule_id"
    t.index ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id"
    t.index ["selected_schedule_id"], name: "index_programs_on_selected_schedule_id"
  end

  create_table "qanswers", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qanswers", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "answer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "qanswers_registrations", id: false, force: :cascade do |t|
    t.integer "registration_id", null: false
    t.integer "qanswer_id", null: false
  end

  create_table "qanswers_registrations", id: false, force: :cascade do |t|
    t.integer "registration_id", null: false
    t.integer "qanswer_id", null: false
  end

  create_table "question_types", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "question_types", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "question_type_id"
    t.integer "conference_id"
    t.boolean "global"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "question_type_id"
    t.integer "conference_id"
    t.boolean "global"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_authentication_devise_roles", id: :serial, force: :cascade do |t|
    t.string "title"
  end

  create_table "refinery_authentication_devise_roles_users", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id", "user_id"], name: "refinery_roles_users_role_id_user_id"
    t.index ["user_id", "role_id"], name: "refinery_roles_users_user_id_role_id"
  end

  create_table "refinery_authentication_devise_user_plugins", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.string "name"
    t.integer "position"
    t.index ["name"], name: "index_refinery_authentication_devise_user_plugins_on_name"
    t.index ["user_id", "name"], name: "refinery_user_plugins_user_id_name", unique: true
  end

  create_table "refinery_authentication_devise_users", id: :serial, force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "sign_in_count"
    t.datetime "remember_created_at"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.string "full_name"
    t.index ["id"], name: "index_refinery_authentication_devise_users_on_id"
    t.index ["slug"], name: "index_refinery_authentication_devise_users_on_slug"
  end

  create_table "refinery_blog_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.index ["id"], name: "index_refinery_blog_categories_on_id"
    t.index ["id"], name: "index_refinery_blog_categories_on_id"
    t.index ["slug"], name: "index_refinery_blog_categories_on_slug"
    t.index ["slug"], name: "index_refinery_blog_categories_on_slug"
  end

  create_table "refinery_blog_categories", id: :serial, force: :cascade do |t|
    t.string "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.index ["id"], name: "index_refinery_blog_categories_on_id"
    t.index ["id"], name: "index_refinery_blog_categories_on_id"
    t.index ["slug"], name: "index_refinery_blog_categories_on_slug"
    t.index ["slug"], name: "index_refinery_blog_categories_on_slug"
  end

  create_table "refinery_blog_categories_blog_posts", id: :serial, force: :cascade do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
    t.index ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp"
    t.index ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp"
  end

  create_table "refinery_blog_categories_blog_posts", id: :serial, force: :cascade do |t|
    t.integer "blog_category_id"
    t.integer "blog_post_id"
    t.index ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp"
    t.index ["blog_category_id", "blog_post_id"], name: "index_blog_categories_blog_posts_on_bc_and_bp"
  end

  create_table "refinery_blog_category_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_blog_category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "slug"
    t.index ["locale"], name: "index_refinery_blog_category_translations_on_locale"
    t.index ["locale"], name: "index_refinery_blog_category_translations_on_locale"
    t.index ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31"
    t.index ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31"
  end

  create_table "refinery_blog_category_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_blog_category_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "slug"
    t.index ["locale"], name: "index_refinery_blog_category_translations_on_locale"
    t.index ["locale"], name: "index_refinery_blog_category_translations_on_locale"
    t.index ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31"
    t.index ["refinery_blog_category_id"], name: "index_a0315945e6213bbe0610724da0ee2de681b77c31"
  end

  create_table "refinery_blog_comments", id: :serial, force: :cascade do |t|
    t.integer "blog_post_id"
    t.boolean "spam"
    t.string "name"
    t.string "email"
    t.text "body"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id"
    t.index ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id"
    t.index ["id"], name: "index_refinery_blog_comments_on_id"
    t.index ["id"], name: "index_refinery_blog_comments_on_id"
  end

  create_table "refinery_blog_comments", id: :serial, force: :cascade do |t|
    t.integer "blog_post_id"
    t.boolean "spam"
    t.string "name"
    t.string "email"
    t.text "body"
    t.string "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id"
    t.index ["blog_post_id"], name: "index_refinery_blog_comments_on_blog_post_id"
    t.index ["id"], name: "index_refinery_blog_comments_on_id"
    t.index ["id"], name: "index_refinery_blog_comments_on_id"
  end

  create_table "refinery_blog_post_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_blog_post_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.text "custom_teaser"
    t.string "custom_url"
    t.string "slug"
    t.string "title"
    t.index ["locale"], name: "index_refinery_blog_post_translations_on_locale"
    t.index ["locale"], name: "index_refinery_blog_post_translations_on_locale"
    t.index ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id"
    t.index ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id"
  end

  create_table "refinery_blog_post_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_blog_post_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.text "custom_teaser"
    t.string "custom_url"
    t.string "slug"
    t.string "title"
    t.index ["locale"], name: "index_refinery_blog_post_translations_on_locale"
    t.index ["locale"], name: "index_refinery_blog_post_translations_on_locale"
    t.index ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id"
    t.index ["refinery_blog_post_id"], name: "index_refinery_blog_post_translations_on_refinery_blog_post_id"
  end

  create_table "refinery_blog_posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "draft"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "custom_url"
    t.text "custom_teaser"
    t.string "source_url"
    t.string "source_url_title"
    t.integer "access_count", default: 0
    t.string "slug"
    t.integer "image_id"
    t.index ["access_count"], name: "index_refinery_blog_posts_on_access_count"
    t.index ["access_count"], name: "index_refinery_blog_posts_on_access_count"
    t.index ["id"], name: "index_refinery_blog_posts_on_id"
    t.index ["id"], name: "index_refinery_blog_posts_on_id"
    t.index ["slug"], name: "index_refinery_blog_posts_on_slug"
    t.index ["slug"], name: "index_refinery_blog_posts_on_slug"
  end

  create_table "refinery_blog_posts", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.boolean "draft"
    t.datetime "published_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
    t.string "custom_url"
    t.text "custom_teaser"
    t.string "source_url"
    t.string "source_url_title"
    t.integer "access_count", default: 0
    t.string "slug"
    t.integer "image_id"
    t.index ["access_count"], name: "index_refinery_blog_posts_on_access_count"
    t.index ["access_count"], name: "index_refinery_blog_posts_on_access_count"
    t.index ["id"], name: "index_refinery_blog_posts_on_id"
    t.index ["id"], name: "index_refinery_blog_posts_on_id"
    t.index ["slug"], name: "index_refinery_blog_posts_on_slug"
    t.index ["slug"], name: "index_refinery_blog_posts_on_slug"
  end

  create_table "refinery_community_events", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.string "url"
    t.datetime "published_at"
    t.string "author"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicfields", id: :serial, force: :cascade do |t|
    t.string "criteria", default: "page_layout"
    t.string "page_layout"
    t.string "page_id"
    t.string "model_title"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicfields", id: :serial, force: :cascade do |t|
    t.string "criteria", default: "page_layout"
    t.string "page_layout"
    t.string "page_id"
    t.string "model_title"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicform_associations", id: :serial, force: :cascade do |t|
    t.integer "dynamicfield_id"
    t.integer "page_id"
  end

  create_table "refinery_dynamicfields_dynamicform_associations", id: :serial, force: :cascade do |t|
    t.integer "dynamicfield_id"
    t.integer "page_id"
  end

  create_table "refinery_dynamicfields_dynamicform_fields", id: :serial, force: :cascade do |t|
    t.integer "dynamicfield_id"
    t.string "field_id"
    t.string "field_label"
    t.string "field_type"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicform_fields", id: :serial, force: :cascade do |t|
    t.integer "dynamicfield_id"
    t.string "field_id"
    t.string "field_label"
    t.string "field_type"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_dynamicfields_dynamicform_values", id: :serial, force: :cascade do |t|
    t.integer "dynamicform_field_id"
    t.integer "dynamicform_association_id"
    t.text "text_value"
    t.integer "resource_id"
    t.integer "image_id"
    t.string "string_value"
  end

  create_table "refinery_dynamicfields_dynamicform_values", id: :serial, force: :cascade do |t|
    t.integer "dynamicform_field_id"
    t.integer "dynamicform_association_id"
    t.text "text_value"
    t.integer "resource_id"
    t.integer "image_id"
    t.string "string_value"
  end

  create_table "refinery_image_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_image_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_alt"
    t.string "image_title"
    t.index ["locale"], name: "index_refinery_image_translations_on_locale"
    t.index ["locale"], name: "index_refinery_image_translations_on_locale"
    t.index ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id"
    t.index ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id"
  end

  create_table "refinery_image_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_image_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "image_alt"
    t.string "image_title"
    t.index ["locale"], name: "index_refinery_image_translations_on_locale"
    t.index ["locale"], name: "index_refinery_image_translations_on_locale"
    t.index ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id"
    t.index ["refinery_image_id"], name: "index_refinery_image_translations_on_refinery_image_id"
  end

  create_table "refinery_images", id: :serial, force: :cascade do |t|
    t.string "image_mime_type"
    t.string "image_name"
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_title"
    t.string "image_alt"
    t.integer "parent_id"
  end

  create_table "refinery_images", id: :serial, force: :cascade do |t|
    t.string "image_mime_type"
    t.string "image_name"
    t.integer "image_size"
    t.integer "image_width"
    t.integer "image_height"
    t.string "image_uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "image_title"
    t.string "image_alt"
    t.integer "parent_id"
  end

  create_table "refinery_meetups", id: :serial, force: :cascade do |t|
    t.string "external_id"
    t.string "title"
    t.text "description"
    t.string "url"
    t.string "picture_url"
    t.datetime "start"
    t.datetime "end"
    t.string "location"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_page_part_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_part_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.index ["locale"], name: "index_refinery_page_part_translations_on_locale"
    t.index ["locale"], name: "index_refinery_page_part_translations_on_locale"
    t.index ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id"
    t.index ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id"
  end

  create_table "refinery_page_part_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_part_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "body"
    t.index ["locale"], name: "index_refinery_page_part_translations_on_locale"
    t.index ["locale"], name: "index_refinery_page_part_translations_on_locale"
    t.index ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id"
    t.index ["refinery_page_part_id"], name: "index_refinery_page_part_translations_on_refinery_page_part_id"
  end

  create_table "refinery_page_parts", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_id"
    t.string "slug"
    t.text "body"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title"
    t.index ["id"], name: "index_refinery_page_parts_on_id"
    t.index ["id"], name: "index_refinery_page_parts_on_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id"
  end

  create_table "refinery_page_parts", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_id"
    t.string "slug"
    t.text "body"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title"
    t.index ["id"], name: "index_refinery_page_parts_on_id"
    t.index ["id"], name: "index_refinery_page_parts_on_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_parts_on_refinery_page_id"
  end

  create_table "refinery_page_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "custom_slug"
    t.string "menu_title"
    t.string "slug"
    t.index ["locale"], name: "index_refinery_page_translations_on_locale"
    t.index ["locale"], name: "index_refinery_page_translations_on_locale"
    t.index ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id"
  end

  create_table "refinery_page_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_page_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.string "custom_slug"
    t.string "menu_title"
    t.string "slug"
    t.index ["locale"], name: "index_refinery_page_translations_on_locale"
    t.index ["locale"], name: "index_refinery_page_translations_on_locale"
    t.index ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id"
    t.index ["refinery_page_id"], name: "index_refinery_page_translations_on_refinery_page_id"
  end

  create_table "refinery_pages", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.string "path"
    t.string "slug"
    t.string "custom_slug"
    t.boolean "show_in_menu", default: true
    t.string "link_url"
    t.string "menu_match"
    t.boolean "deletable", default: true
    t.boolean "draft", default: false
    t.boolean "skip_to_first_child", default: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string "view_template"
    t.string "layout_template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["depth"], name: "index_refinery_pages_on_depth"
    t.index ["depth"], name: "index_refinery_pages_on_depth"
    t.index ["id"], name: "index_refinery_pages_on_id"
    t.index ["id"], name: "index_refinery_pages_on_id"
    t.index ["lft"], name: "index_refinery_pages_on_lft"
    t.index ["lft"], name: "index_refinery_pages_on_lft"
    t.index ["parent_id"], name: "index_refinery_pages_on_parent_id"
    t.index ["parent_id"], name: "index_refinery_pages_on_parent_id"
    t.index ["rgt"], name: "index_refinery_pages_on_rgt"
    t.index ["rgt"], name: "index_refinery_pages_on_rgt"
  end

  create_table "refinery_pages", id: :serial, force: :cascade do |t|
    t.integer "parent_id"
    t.string "path"
    t.string "slug"
    t.string "custom_slug"
    t.boolean "show_in_menu", default: true
    t.string "link_url"
    t.string "menu_match"
    t.boolean "deletable", default: true
    t.boolean "draft", default: false
    t.boolean "skip_to_first_child", default: false
    t.integer "lft"
    t.integer "rgt"
    t.integer "depth"
    t.string "view_template"
    t.string "layout_template"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["depth"], name: "index_refinery_pages_on_depth"
    t.index ["depth"], name: "index_refinery_pages_on_depth"
    t.index ["id"], name: "index_refinery_pages_on_id"
    t.index ["id"], name: "index_refinery_pages_on_id"
    t.index ["lft"], name: "index_refinery_pages_on_lft"
    t.index ["lft"], name: "index_refinery_pages_on_lft"
    t.index ["parent_id"], name: "index_refinery_pages_on_parent_id"
    t.index ["parent_id"], name: "index_refinery_pages_on_parent_id"
    t.index ["rgt"], name: "index_refinery_pages_on_rgt"
    t.index ["rgt"], name: "index_refinery_pages_on_rgt"
  end

  create_table "refinery_resource_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_resource_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_title"
    t.index ["locale"], name: "index_refinery_resource_translations_on_locale"
    t.index ["locale"], name: "index_refinery_resource_translations_on_locale"
    t.index ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id"
    t.index ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id"
  end

  create_table "refinery_resource_translations", id: :serial, force: :cascade do |t|
    t.integer "refinery_resource_id", null: false
    t.string "locale", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "resource_title"
    t.index ["locale"], name: "index_refinery_resource_translations_on_locale"
    t.index ["locale"], name: "index_refinery_resource_translations_on_locale"
    t.index ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id"
    t.index ["refinery_resource_id"], name: "index_refinery_resource_translations_on_refinery_resource_id"
  end

  create_table "refinery_resources", id: :serial, force: :cascade do |t|
    t.string "file_mime_type"
    t.string "file_name"
    t.integer "file_size"
    t.string "file_uid"
    t.string "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_resources", id: :serial, force: :cascade do |t|
    t.string "file_mime_type"
    t.string "file_name"
    t.integer "file_size"
    t.string "file_uid"
    t.string "file_ext"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_settings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.boolean "destroyable", default: true
    t.string "scoping"
    t.boolean "restricted", default: false
    t.string "form_value_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.string "title"
    t.index ["name"], name: "index_refinery_settings_on_name"
    t.index ["name"], name: "index_refinery_settings_on_name"
  end

  create_table "refinery_settings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "value"
    t.boolean "destroyable", default: true
    t.string "scoping"
    t.boolean "restricted", default: false
    t.string "form_value_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "slug"
    t.string "title"
    t.index ["name"], name: "index_refinery_settings_on_name"
    t.index ["name"], name: "index_refinery_settings_on_name"
  end

  create_table "refinery_sponsors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "logo_id"
    t.text "description"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sponsorship_level_id"
    t.index ["sponsorship_level_id"], name: "index_refinery_sponsors_on_sponsorship_level_id"
    t.index ["sponsorship_level_id"], name: "index_refinery_sponsors_on_sponsorship_level_id"
  end

  create_table "refinery_sponsors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "url"
    t.integer "logo_id"
    t.text "description"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "sponsorship_level_id"
    t.index ["sponsorship_level_id"], name: "index_refinery_sponsors_on_sponsorship_level_id"
    t.index ["sponsorship_level_id"], name: "index_refinery_sponsors_on_sponsorship_level_id"
  end

  create_table "refinery_sponsors_sponsorship_levels", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_sponsors_sponsorship_levels", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "refinery_team_members", id: :serial, force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "role"
    t.integer "photo_id"
    t.text "description"
    t.string "twitter"
    t.string "linkedin"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "show_on_homepage", default: false
  end

  create_table "refinery_team_members", id: :serial, force: :cascade do |t|
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.string "role"
    t.integer "photo_id"
    t.text "description"
    t.string "twitter"
    t.string "linkedin"
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "show_on_homepage", default: false
  end

  create_table "registration_periods", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "early_bird_date"
  end

  create_table "registration_periods", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.date "start_date"
    t.date "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date "early_bird_date"
  end

  create_table "registrations", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "arrival"
    t.datetime "departure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "other_special_needs"
    t.boolean "attended", default: false
    t.boolean "volunteer"
    t.integer "user_id"
    t.integer "week"
  end

  create_table "registrations", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.datetime "arrival"
    t.datetime "departure"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "other_special_needs"
    t.boolean "attended", default: false
    t.boolean "volunteer"
    t.integer "user_id"
    t.integer "week"
  end

  create_table "registrations_vchoices", id: false, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "vchoice_id"
  end

  create_table "registrations_vchoices", id: false, force: :cascade do |t|
    t.integer "registration_id"
    t.integer "vchoice_id"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
    t.integer "resource_id"
    t.string "resource_type"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "description"
    t.integer "resource_id"
    t.string "resource_type"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "room_locations", id: :serial, force: :cascade do |t|
    t.integer "venue_id"
    t.string "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["venue_id"], name: "index_room_locations_on_venue_id"
  end

  create_table "rooms", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.string "name", null: false
    t.integer "size"
    t.integer "venue_id", null: false
    t.integer "room_location_id"
    t.date "start_date"
    t.date "end_date"
  end

  create_table "rooms", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.string "name", null: false
    t.integer "size"
    t.integer "venue_id", null: false
    t.integer "room_location_id"
    t.date "start_date"
    t.date "end_date"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_schedules_on_program_id"
    t.index ["program_id"], name: "index_schedules_on_program_id"
  end

  create_table "schedules", id: :serial, force: :cascade do |t|
    t.integer "program_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_schedules_on_program_id"
    t.index ["program_id"], name: "index_schedules_on_program_id"
  end

  create_table "seo_meta", id: :serial, force: :cascade do |t|
    t.integer "seo_meta_id"
    t.string "seo_meta_type"
    t.string "browser_title"
    t.text "meta_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_seo_meta_on_id"
    t.index ["id"], name: "index_seo_meta_on_id"
    t.index ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta"
    t.index ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta"
  end

  create_table "seo_meta", id: :serial, force: :cascade do |t|
    t.integer "seo_meta_id"
    t.string "seo_meta_type"
    t.string "browser_title"
    t.text "meta_description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["id"], name: "index_seo_meta_on_id"
    t.index ["id"], name: "index_seo_meta_on_id"
    t.index ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta"
    t.index ["seo_meta_id", "seo_meta_type"], name: "id_type_index_on_seo_meta"
  end

  create_table "speaker_invitations", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.string "email"
    t.string "token"
    t.boolean "accepted", default: false, null: false
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_speaker_invitations_on_event_id"
    t.index ["user_id"], name: "index_speaker_invitations_on_user_id"
  end

  create_table "splashpages", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.boolean "public"
    t.boolean "include_tracks"
    t.boolean "include_program"
    t.boolean "include_social_media"
    t.boolean "include_venue"
    t.boolean "include_tickets"
    t.boolean "include_registrations"
    t.boolean "include_sponsors"
    t.boolean "include_lodgings"
    t.string "banner_photo_file_name"
    t.string "banner_photo_content_type"
    t.integer "banner_photo_file_size"
    t.datetime "banner_photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "include_cfp", default: false
    t.boolean "include_activities", default: false
    t.boolean "include_advantages", default: false
    t.text "custom_tags"
  end

  create_table "splashpages", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.boolean "public"
    t.boolean "include_tracks"
    t.boolean "include_program"
    t.boolean "include_social_media"
    t.boolean "include_venue"
    t.boolean "include_tickets"
    t.boolean "include_registrations"
    t.boolean "include_sponsors"
    t.boolean "include_lodgings"
    t.string "banner_photo_file_name"
    t.string "banner_photo_content_type"
    t.integer "banner_photo_file_size"
    t.datetime "banner_photo_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "include_cfp", default: false
    t.boolean "include_activities", default: false
    t.boolean "include_advantages", default: false
    t.text "custom_tags"
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "website_url"
    t.string "logo_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "picture"
    t.string "short_name"
    t.index ["short_name"], name: "index_sponsors_on_short_name", unique: true
    t.index ["short_name"], name: "index_sponsors_on_short_name", unique: true
  end

  create_table "sponsors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "website_url"
    t.string "logo_file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "picture"
    t.string "short_name"
    t.index ["short_name"], name: "index_sponsors_on_short_name", unique: true
    t.index ["short_name"], name: "index_sponsors_on_short_name", unique: true
  end

  create_table "sponsors_backup", id: false, force: :cascade do |t|
    t.integer "id"
    t.string "name"
    t.text "description"
    t.string "website_url"
    t.string "logo_file_name"
    t.integer "sponsorship_level_id"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "picture"
  end

  create_table "sponsors_users", id: false, force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "user_id"
    t.index ["user_id"], name: "index_sponsors_users_on_user_id", unique: true
  end

  create_table "sponsors_users", id: false, force: :cascade do |t|
    t.integer "sponsor_id"
    t.integer "user_id"
    t.index ["user_id"], name: "index_sponsors_users_on_user_id", unique: true
  end

  create_table "sponsorship_infos", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "conference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prospectus"
    t.string "liaison_email"
    t.string "manual"
    t.index ["conference_id"], name: "index_sponsorship_infos_on_conference_id"
    t.index ["conference_id"], name: "index_sponsorship_infos_on_conference_id"
  end

  create_table "sponsorship_infos", id: :serial, force: :cascade do |t|
    t.text "description"
    t.integer "conference_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prospectus"
    t.string "liaison_email"
    t.string "manual"
    t.index ["conference_id"], name: "index_sponsorship_infos_on_conference_id"
    t.index ["conference_id"], name: "index_sponsorship_infos_on_conference_id"
  end

  create_table "sponsorship_levels", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
  end

  create_table "sponsorship_levels", id: :serial, force: :cascade do |t|
    t.string "title"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "position"
  end

  create_table "sponsorship_levels_benefits", id: :serial, force: :cascade do |t|
    t.integer "sponsorship_level_id"
    t.integer "benefit_id"
    t.integer "code_type_id"
    t.integer "max_uses"
    t.integer "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id"
    t.index ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id"
  end

  create_table "sponsorship_levels_benefits", id: :serial, force: :cascade do |t|
    t.integer "sponsorship_level_id"
    t.integer "benefit_id"
    t.integer "code_type_id"
    t.integer "max_uses"
    t.integer "discount"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id"
    t.index ["sponsorship_level_id"], name: "index_sponsorship_levels_benefits_on_sponsorship_level_id"
  end

  create_table "sponsorships", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.integer "sponsor_id", null: false
    t.integer "sponsorship_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true
    t.index ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true
  end

  create_table "sponsorships", id: :serial, force: :cascade do |t|
    t.integer "conference_id", null: false
    t.integer "sponsor_id", null: false
    t.integer "sponsorship_level_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true
    t.index ["conference_id", "sponsor_id"], name: "index_sponsorships_on_conference_id_and_sponsor_id", unique: true
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "subscriptions", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.integer "conference_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_answers", id: :serial, force: :cascade do |t|
    t.integer "attempt_id"
    t.integer "question_id"
    t.integer "option_id"
    t.boolean "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["question_id", "option_id"], name: "survey_answers_question_option_id_idx"
  end

  create_table "survey_answers", id: :serial, force: :cascade do |t|
    t.integer "attempt_id"
    t.integer "question_id"
    t.integer "option_id"
    t.boolean "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["question_id", "option_id"], name: "survey_answers_question_option_id_idx"
  end

  create_table "survey_attempts", id: :serial, force: :cascade do |t|
    t.integer "participant_id"
    t.string "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_attempts", id: :serial, force: :cascade do |t|
    t.integer "participant_id"
    t.string "participant_type"
    t.integer "survey_id"
    t.boolean "winner"
    t.integer "score"
  end

  create_table "survey_options", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "weight", default: 0
    t.string "text"
    t.boolean "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_options", id: :serial, force: :cascade do |t|
    t.integer "question_id"
    t.integer "weight", default: 0
    t.string "text"
    t.boolean "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_questions", id: :serial, force: :cascade do |t|
    t.integer "survey_id"
    t.string "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "imported", default: false
  end

  create_table "survey_questions", id: :serial, force: :cascade do |t|
    t.integer "survey_id"
    t.string "text"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean "imported", default: false
  end

  create_table "survey_surveys", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "attempts_number", default: 0
    t.boolean "finished", default: false
    t.boolean "active", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "survey_surveys", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "attempts_number", default: 0
    t.boolean "finished", default: false
    t.boolean "active", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context"
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  end

  create_table "taggings", id: :serial, force: :cascade do |t|
    t.integer "tag_id"
    t.integer "taggable_id"
    t.string "taggable_type"
    t.integer "tagger_id"
    t.string "tagger_type"
    t.string "context"
    t.datetime "created_at"
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
    t.index ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "tags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.integer "taggings_count", default: 0
    t.index ["name"], name: "index_tags_on_name", unique: true
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "targets", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "campaign_id"
    t.date "due_date"
    t.integer "target_count"
    t.string "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "targets", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.integer "campaign_id"
    t.date "due_date"
    t.integer "target_count"
    t.string "unit"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_group_benefits", id: :serial, force: :cascade do |t|
    t.integer "ticket_group_id", null: false
    t.string "name", null: false
    t.text "description", null: false
    t.integer "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ticket_group_benefits_tickets", id: false, force: :cascade do |t|
    t.integer "ticket_group_benefit_id", null: false
    t.integer "ticket_id", null: false
    t.index ["ticket_group_benefit_id", "ticket_id"], name: "tg_benefit_tix_idx", unique: true
  end

  create_table "ticket_groups", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "name"
    t.string "description"
    t.integer "position"
    t.text "additional_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id"], name: "index_ticket_groups_on_conference_id"
    t.index ["conference_id"], name: "index_ticket_groups_on_conference_id"
  end

  create_table "ticket_groups", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "name"
    t.string "description"
    t.integer "position"
    t.text "additional_details"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["conference_id"], name: "index_ticket_groups_on_conference_id"
    t.index ["conference_id"], name: "index_ticket_groups_on_conference_id"
  end

  create_table "ticket_purchases", id: :serial, force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "conference_id"
    t.boolean "paid", default: false
    t.datetime "created_at"
    t.integer "quantity", default: 1
    t.integer "user_id"
    t.integer "payment_id"
    t.integer "code_id"
    t.integer "event_id"
    t.string "pending_event_tickets"
    t.integer "purchase_price_cents", default: 0, null: false
    t.string "purchase_price_currency", default: "USD", null: false
    t.index ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id"
    t.index ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id"
    t.index ["event_id"], name: "index_ticket_purchases_on_event_id"
    t.index ["event_id"], name: "index_ticket_purchases_on_event_id"
  end

  create_table "ticket_purchases", id: :serial, force: :cascade do |t|
    t.integer "ticket_id"
    t.integer "conference_id"
    t.boolean "paid", default: false
    t.datetime "created_at"
    t.integer "quantity", default: 1
    t.integer "user_id"
    t.integer "payment_id"
    t.integer "code_id"
    t.integer "event_id"
    t.string "pending_event_tickets"
    t.integer "purchase_price_cents", default: 0, null: false
    t.string "purchase_price_currency", default: "USD", null: false
    t.index ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id"
    t.index ["conference_id", "code_id"], name: "index_ticket_purchases_on_conference_id_and_code_id"
    t.index ["event_id"], name: "index_ticket_purchases_on_event_id"
    t.index ["event_id"], name: "index_ticket_purchases_on_event_id"
  end

  create_table "ticket_scannings", id: :serial, force: :cascade do |t|
    t.integer "physical_ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ticket_scannings", id: :serial, force: :cascade do |t|
    t.integer "physical_ticket_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "title", null: false
    t.text "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.boolean "hidden", default: false
    t.integer "position"
    t.integer "ticket_group_id"
    t.string "short_title"
    t.integer "early_bird_price_cents", default: 0, null: false
    t.string "early_bird_price_currency", default: "USD", null: false
    t.integer "ticket_type", default: 0
    t.date "start_date"
    t.date "end_date"
    t.text "extra_info"
    t.integer "max_per_purchase", default: 10
    t.index ["ticket_group_id"], name: "index_tickets_on_ticket_group_id"
    t.index ["ticket_group_id"], name: "index_tickets_on_ticket_group_id"
  end

  create_table "tickets", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "title", null: false
    t.text "description"
    t.integer "price_cents", default: 0, null: false
    t.string "price_currency", default: "USD", null: false
    t.boolean "hidden", default: false
    t.integer "position"
    t.integer "ticket_group_id"
    t.string "short_title"
    t.integer "early_bird_price_cents", default: 0, null: false
    t.string "early_bird_price_currency", default: "USD", null: false
    t.integer "ticket_type", default: 0
    t.date "start_date"
    t.date "end_date"
    t.text "extra_info"
    t.integer "max_per_purchase", default: 10
    t.index ["ticket_group_id"], name: "index_tickets_on_ticket_group_id"
    t.index ["ticket_group_id"], name: "index_tickets_on_ticket_group_id"
  end

  create_table "tracks", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.string "name", null: false
    t.text "description"
    t.string "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "program_id"
  end

  create_table "tracks", id: :serial, force: :cascade do |t|
    t.string "guid", null: false
    t.string "name", null: false
    t.text "description"
    t.string "color"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "program_id"
  end

  create_table "userdata", id: :serial, force: :cascade do |t|
    t.string "email"
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "affiliation"
    t.string "title"
    t.string "biography"
    t.string "type"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "name"
    t.boolean "email_public"
    t.text "biography"
    t.string "nickname"
    t.string "affiliation"
    t.string "avatar_file_name"
    t.string "avatar_content_type"
    t.integer "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string "mobile"
    t.string "tshirt"
    t.string "languages"
    t.text "volunteer_experience"
    t.boolean "is_admin", default: false
    t.string "username"
    t.boolean "is_disabled", default: false
    t.string "avatar"
    t.string "first_name"
    t.string "last_name"
    t.string "title"
    t.string "slug"
    t.boolean "guest", default: false
    t.string "country"
    t.string "state"
    t.string "city"
    t.integer "nickname_type", default: 0
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
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "users_roles", id: :serial, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "vchoices", id: :serial, force: :cascade do |t|
    t.integer "vday_id"
    t.integer "vposition_id"
  end

  create_table "vchoices", id: :serial, force: :cascade do |t|
    t.integer "vday_id"
    t.integer "vposition_id"
  end

  create_table "vdays", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.date "day"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vdays", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.date "day"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "venues", id: :serial, force: :cascade do |t|
    t.string "guid"
    t.string "name"
    t.string "website"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name"
    t.string "street"
    t.string "postalcode"
    t.string "city"
    t.string "country"
    t.string "latitude"
    t.string "longitude"
    t.integer "conference_id"
    t.string "picture"
    t.string "state"
  end

  create_table "venues", id: :serial, force: :cascade do |t|
    t.string "guid"
    t.string "name"
    t.string "website"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "photo_file_name"
    t.string "street"
    t.string "postalcode"
    t.string "city"
    t.string "country"
    t.string "latitude"
    t.string "longitude"
    t.integer "conference_id"
    t.string "picture"
    t.string "state"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.text "object_changes"
    t.datetime "created_at"
    t.integer "conference_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.text "object_changes"
    t.datetime "created_at"
    t.integer "conference_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "visits", id: :serial, force: :cascade do |t|
    t.uuid "visitor_id"
    t.string "ip"
    t.text "user_agent"
    t.text "referrer"
    t.text "landing_page"
    t.integer "user_id"
    t.string "referring_domain"
    t.string "search_keyword"
    t.string "browser"
    t.string "os"
    t.string "device_type"
    t.string "country"
    t.string "region"
    t.string "city"
    t.string "utm_source"
    t.string "utm_medium"
    t.string "utm_term"
    t.string "utm_content"
    t.string "utm_campaign"
    t.datetime "started_at"
    t.index ["user_id"], name: "index_visits_on_user_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "votes", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "user_id"
  end

  create_table "vpositions", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vpositions", id: :serial, force: :cascade do |t|
    t.integer "conference_id"
    t.string "title", null: false
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_foreign_key "advantages", "conferences"
  add_foreign_key "alchemy_contents", "alchemy_elements", column: "element_id", on_update: :cascade, on_delete: :cascade
  add_foreign_key "alchemy_elements", "alchemy_page_versions", column: "page_version_id", on_delete: :cascade
  add_foreign_key "alchemy_essence_nodes", "alchemy_nodes", column: "node_id"
  add_foreign_key "alchemy_essence_pages", "alchemy_pages", column: "page_id"
  add_foreign_key "alchemy_ingredients", "alchemy_elements", column: "element_id", on_delete: :cascade
  add_foreign_key "alchemy_nodes", "alchemy_languages", column: "language_id"
  add_foreign_key "alchemy_nodes", "alchemy_pages", column: "page_id", on_delete: :restrict
  add_foreign_key "alchemy_page_versions", "alchemy_pages", column: "page_id", on_delete: :cascade
  add_foreign_key "alchemy_pages", "alchemy_languages", column: "language_id"
  add_foreign_key "alchemy_picture_thumbs", "alchemy_pictures", column: "picture_id"
  add_foreign_key "benefit_responses", "benefits"
  add_foreign_key "benefit_responses", "conferences"
  add_foreign_key "benefit_responses", "public.benefits", column: "benefit_id"
  add_foreign_key "benefit_responses", "public.conferences", column: "conference_id"
  add_foreign_key "benefit_responses", "public.sponsorships", column: "sponsorship_id"
  add_foreign_key "benefit_responses", "sponsorships"
  add_foreign_key "benefit_responses", "benefits"
  add_foreign_key "benefit_responses", "conferences"
  add_foreign_key "benefit_responses", "public.benefits", column: "benefit_id"
  add_foreign_key "benefit_responses", "public.conferences", column: "conference_id"
  add_foreign_key "benefit_responses", "public.sponsorships", column: "sponsorship_id"
  add_foreign_key "benefit_responses", "sponsorships"
  add_foreign_key "benefits", "conferences"
  add_foreign_key "benefits", "public.conferences", column: "conference_id"
  add_foreign_key "benefits", "conferences"
  add_foreign_key "benefits", "public.conferences", column: "conference_id"
  add_foreign_key "boomset_guests", "conferences"
  add_foreign_key "boomset_guests", "integrations"
  add_foreign_key "boomset_guests", "registrations"
  add_foreign_key "boomset_ticket_configs", "conferences"
  add_foreign_key "boomset_ticket_configs", "integrations"
  add_foreign_key "boomset_ticket_configs", "tickets"
  add_foreign_key "campaigns", "sponsors"
  add_foreign_key "campaigns", "sponsors"
  add_foreign_key "codes", "code_types"
  add_foreign_key "codes", "conferences"
  add_foreign_key "codes", "public.code_types", column: "code_type_id"
  add_foreign_key "codes", "public.conferences", column: "conference_id"
  add_foreign_key "codes", "public.sponsors", column: "sponsor_id"
  add_foreign_key "codes", "sponsors"
  add_foreign_key "codes", "code_types"
  add_foreign_key "codes", "conferences"
  add_foreign_key "codes", "public.code_types", column: "code_type_id"
  add_foreign_key "codes", "public.conferences", column: "conference_id"
  add_foreign_key "codes", "public.sponsors", column: "sponsor_id"
  add_foreign_key "codes", "sponsors"
  add_foreign_key "codes_tickets", "codes"
  add_foreign_key "codes_tickets", "public.codes", column: "code_id"
  add_foreign_key "codes_tickets", "public.tickets", column: "ticket_id"
  add_foreign_key "codes_tickets", "tickets"
  add_foreign_key "codes_tickets", "codes"
  add_foreign_key "codes_tickets", "public.codes", column: "code_id"
  add_foreign_key "codes_tickets", "public.tickets", column: "ticket_id"
  add_foreign_key "codes_tickets", "tickets"
  add_foreign_key "conference_team_members", "conferences"
  add_foreign_key "conference_team_members", "refinery_team_members"
  add_foreign_key "conferences", "conference_groups"
  add_foreign_key "conferences", "conference_groups"
  add_foreign_key "conferences_codes", "codes"
  add_foreign_key "conferences_codes", "conferences"
  add_foreign_key "conferences_codes", "public.codes", column: "code_id"
  add_foreign_key "conferences_codes", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_codes", "codes"
  add_foreign_key "conferences_codes", "conferences"
  add_foreign_key "conferences_codes", "public.codes", column: "code_id"
  add_foreign_key "conferences_codes", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_doh", "conference_groups"
  add_foreign_key "conferences_doh_2", "conference_groups"
  add_foreign_key "conferences_policies", "conferences"
  add_foreign_key "conferences_policies", "policies"
  add_foreign_key "conferences_policies", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_policies", "public.policies", column: "policy_id"
  add_foreign_key "conferences_policies", "conferences"
  add_foreign_key "conferences_policies", "policies"
  add_foreign_key "conferences_policies", "public.conferences", column: "conference_id"
  add_foreign_key "conferences_policies", "public.policies", column: "policy_id"
  add_foreign_key "events", "public.tickets", column: "ticket_id"
  add_foreign_key "events", "tickets"
  add_foreign_key "events", "public.tickets", column: "ticket_id"
  add_foreign_key "events", "tickets"
  add_foreign_key "integrations", "conferences"
  add_foreign_key "payment_methods", "conferences"
  add_foreign_key "payment_methods", "public.conferences", column: "conference_id"
  add_foreign_key "payment_methods", "conferences"
  add_foreign_key "payment_methods", "public.conferences", column: "conference_id"
  add_foreign_key "physical_tickets", "events"
  add_foreign_key "physical_tickets", "public.events", column: "event_id"
  add_foreign_key "physical_tickets", "public.registrations", column: "registration_id"
  add_foreign_key "physical_tickets", "registrations"
  add_foreign_key "physical_tickets", "users"
  add_foreign_key "physical_tickets", "events"
  add_foreign_key "physical_tickets", "public.events", column: "event_id"
  add_foreign_key "physical_tickets", "public.registrations", column: "registration_id"
  add_foreign_key "physical_tickets", "registrations"
  add_foreign_key "physical_tickets", "users"
  add_foreign_key "policies", "conferences"
  add_foreign_key "policies", "public.conferences", column: "conference_id"
  add_foreign_key "policies", "conferences"
  add_foreign_key "policies", "public.conferences", column: "conference_id"
  add_foreign_key "polls", "conferences"
  add_foreign_key "polls", "public.conferences", column: "conference_id"
  add_foreign_key "polls", "public.survey_surveys", column: "survey_id"
  add_foreign_key "polls", "survey_surveys", column: "survey_id"
  add_foreign_key "polls", "conferences"
  add_foreign_key "polls", "public.conferences", column: "conference_id"
  add_foreign_key "polls", "public.survey_surveys", column: "survey_id"
  add_foreign_key "polls", "survey_surveys", column: "survey_id"
  add_foreign_key "refinery_sponsors", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "refinery_sponsors", "sponsorship_levels"
  add_foreign_key "refinery_sponsors", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "refinery_sponsors", "sponsorship_levels"
  add_foreign_key "room_locations", "venues"
  add_foreign_key "rooms", "room_locations"
  add_foreign_key "rooms", "room_locations"
  add_foreign_key "speaker_invitations", "events"
  add_foreign_key "speaker_invitations", "users"
  add_foreign_key "sponsors_users", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsors_users", "sponsors"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsors_users", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsors_users", "sponsors"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsors_users", "users"
  add_foreign_key "sponsorship_infos", "conferences"
  add_foreign_key "sponsorship_infos", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorship_infos", "conferences"
  add_foreign_key "sponsorship_infos", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorship_levels_benefits", "benefits"
  add_foreign_key "sponsorship_levels_benefits", "public.benefits", column: "benefit_id"
  add_foreign_key "sponsorship_levels_benefits", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorship_levels_benefits", "sponsorship_levels"
  add_foreign_key "sponsorship_levels_benefits", "benefits"
  add_foreign_key "sponsorship_levels_benefits", "public.benefits", column: "benefit_id"
  add_foreign_key "sponsorship_levels_benefits", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorship_levels_benefits", "sponsorship_levels"
  add_foreign_key "sponsorships", "conferences"
  add_foreign_key "sponsorships", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorships", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsorships", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorships", "sponsors"
  add_foreign_key "sponsorships", "sponsorship_levels"
  add_foreign_key "sponsorships", "conferences"
  add_foreign_key "sponsorships", "public.conferences", column: "conference_id"
  add_foreign_key "sponsorships", "public.sponsors", column: "sponsor_id"
  add_foreign_key "sponsorships", "public.sponsorship_levels", column: "sponsorship_level_id"
  add_foreign_key "sponsorships", "sponsors"
  add_foreign_key "sponsorships", "sponsorship_levels"
  add_foreign_key "ticket_group_benefits", "ticket_groups"
  add_foreign_key "ticket_group_benefits_tickets", "ticket_group_benefits"
  add_foreign_key "ticket_group_benefits_tickets", "tickets"
  add_foreign_key "ticket_groups", "conferences"
  add_foreign_key "ticket_groups", "public.conferences", column: "conference_id"
  add_foreign_key "ticket_groups", "conferences"
  add_foreign_key "ticket_groups", "public.conferences", column: "conference_id"
  add_foreign_key "ticket_purchases", "codes"
  add_foreign_key "ticket_purchases", "events"
  add_foreign_key "ticket_purchases", "public.codes", column: "code_id"
  add_foreign_key "ticket_purchases", "public.events", column: "event_id"
  add_foreign_key "ticket_purchases", "codes"
  add_foreign_key "ticket_purchases", "events"
  add_foreign_key "ticket_purchases", "public.codes", column: "code_id"
  add_foreign_key "ticket_purchases", "public.events", column: "event_id"
  add_foreign_key "tickets", "public.ticket_groups", column: "ticket_group_id"
  add_foreign_key "tickets", "ticket_groups"
  add_foreign_key "tickets", "public.ticket_groups", column: "ticket_group_id"
  add_foreign_key "tickets", "ticket_groups"
end
