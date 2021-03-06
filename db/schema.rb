# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141104211248) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_tokens", force: true do |t|
    t.string   "token"
    t.integer  "user_id"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "attachments", force: true do |t|
    t.string   "attachment"
    t.string   "attachable_type"
    t.integer  "attachable_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "name"
  end

  add_index "attachments", ["attachable_id", "attachable_type"], name: "index_attachments_on_attachable_id_and_attachable_type", using: :btree

  create_table "authentications", force: true do |t|
    t.string   "provider"
    t.string   "uuid"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "carts", force: true do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "shipping_boolean", default: true
  end

  create_table "categories", force: true do |t|
    t.string   "name"
    t.integer  "sort"
    t.integer  "parent_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "value"
    t.integer  "products_count"
  end

  create_table "categories_products", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "product_id"
  end

  create_table "charges", id: false, force: true do |t|
    t.string   "id",              null: false
    t.boolean  "livemode"
    t.datetime "created_at"
    t.string   "status"
    t.string   "currency"
    t.text     "description"
    t.string   "reference_id"
    t.string   "failure_code"
    t.string   "failure_message"
    t.float    "amount"
    t.string   "card_name"
    t.string   "card_exp_month"
    t.string   "card_exp_year"
    t.string   "card_auth_code"
    t.string   "card_last4"
    t.string   "card_brand"
    t.datetime "updated_at"
  end

  create_table "cities", force: true do |t|
    t.string  "name"
    t.integer "state_id"
    t.decimal "longitude"
    t.decimal "latitude"
  end

  add_index "cities", ["name"], name: "index_cities_on_name", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "commontator_comments", force: true do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                      null: false
    t.text     "body",                           null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_total", default: 0
    t.integer  "cached_votes_up",    default: 0
    t.integer  "cached_votes_down",  default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_total"], name: "index_commontator_comments_on_cached_votes_total", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_c_c_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id"], name: "index_commontator_comments_on_thread_id", using: :btree

  create_table "commontator_subscriptions", force: true do |t|
    t.string   "subscriber_type",             null: false
    t.integer  "subscriber_id",               null: false
    t.integer  "thread_id",                   null: false
    t.integer  "unread",          default: 0, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_c_s_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: true do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_c_t_on_c_id_and_c_type", unique: true, using: :btree

  create_table "conversations", force: true do |t|
    t.text     "body"
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "unread_by_id"
    t.text     "last_message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "conversations", ["from_id", "to_id"], name: "index_conversations_on_from_id_and_to_id", using: :btree

  create_table "event_payments", force: true do |t|
    t.integer "event_id"
    t.integer "user_id"
    t.integer "event_price"
    t.integer "grand_total"
    t.boolean "paid",                   default: false
    t.integer "event_sale_category_id"
    t.boolean "oxxo_ready",             default: false
    t.date    "oxxo_expires_on"
    t.string  "oxxo_barcode"
    t.integer "amount_paid"
    t.integer "position"
    t.string  "conekta_charge_id"
    t.string  "barcode_url"
  end

  create_table "event_product_payments", force: true do |t|
    t.integer "event_product_id"
    t.integer "event_payment_id"
    t.integer "event_id"
    t.integer "user_id"
    t.integer "units"
    t.integer "unit_price"
    t.integer "total"
  end

  create_table "event_products", force: true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "event_products", ["event_id"], name: "index_event_products_on_event_id", using: :btree

  create_table "event_requests", force: true do |t|
    t.integer  "event_id"
    t.integer  "user_id"
    t.boolean  "accepted"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_sale_categories", force: true do |t|
    t.integer "event_id"
    t.string  "name"
    t.integer "price"
    t.string  "positions"
  end

  create_table "event_schedule_categories", force: true do |t|
    t.string   "name"
    t.integer  "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "event_schedules", force: true do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string   "name"
    t.integer  "event_schedule_category_id"
    t.integer  "event_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "address"
    t.integer  "spaces"
    t.string   "cover"
    t.integer  "user_id"
    t.integer  "price"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
    t.decimal  "lat"
    t.decimal  "lng"
    t.string   "location"
    t.string   "zip"
    t.string   "phone"
    t.integer  "city_id"
    t.string   "municipality"
    t.text     "notes"
    t.text     "benefits"
    t.string   "location_name"
    t.string   "location_map"
    t.string   "slug"
    t.text     "requirements"
    t.boolean  "paid",                    default: false
    t.text     "info_for_accepted_users"
    t.integer  "attachments_count"
    t.integer  "plan_id"
    t.string   "conekta_charge_id"
    t.string   "bank_name"
    t.string   "bank_account"
    t.string   "bank_account_full_name"
    t.string   "bank_clabe"
  end

  create_table "events_users", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "event_id"
  end

  create_table "followings", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "likes", force: true do |t|
    t.integer  "user_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", force: true do |t|
    t.integer  "from_id"
    t.text     "body"
    t.integer  "conversation_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "messages", ["conversation_id"], name: "index_messages_on_conversation_id", using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "from_id"
    t.integer  "to_id"
    t.integer  "comment_id"
    t.string   "code"
    t.boolean  "read",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "product_id"
  end

  create_table "order_addresses", force: true do |t|
    t.integer  "user_id"
    t.string   "street"
    t.string   "in_between_street"
    t.integer  "number"
    t.integer  "inner_number"
    t.string   "neighborhood"
    t.integer  "zip"
    t.string   "reference"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "address_title"
    t.integer  "city"
    t.integer  "state"
  end

  create_table "order_items", force: true do |t|
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id"
    t.integer  "total"
    t.string   "conekta_token"
    t.integer  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "oxxo_ready"
    t.date     "oxxo_expires_on"
    t.string   "oxxo_barcode"
    t.string   "conekta_charge_id"
    t.string   "barcode_url"
  end

  create_table "premium_user_data", force: true do |t|
    t.string   "account_owner"
    t.string   "bank_account"
    t.string   "clabe"
    t.string   "rfc"
    t.string   "bank_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "premium_users", force: true do |t|
    t.integer  "premium_user"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.integer  "price"
    t.text     "about"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "category_id"
    t.string   "amount"
    t.integer  "likes_count",       default: 0
    t.integer  "attachments_count"
    t.integer  "shipping",          default: 0
  end

  create_table "states", force: true do |t|
    t.string "name"
  end

  add_index "states", ["name"], name: "index_states_on_name", using: :btree

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], name: "index_taggings_on_tag_id", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  create_table "users", force: true do |t|
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "nickname"
    t.string   "name"
    t.string   "avatar"
    t.text     "about"
    t.string   "address"
    t.integer  "zipcode"
    t.integer  "city_id"
    t.integer  "state_id"
    t.integer  "country_id"
    t.string   "geolocation"
    t.string   "occupation"
    t.date     "birthday"
    t.integer  "last_product_id"
    t.string   "cover"
    t.integer  "products_count"
    t.integer  "default_shipping_address"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["nickname"], name: "index_users_on_nickname", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
