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

ActiveRecord::Schema.define(version: 20150630025713) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_goals", force: :cascade do |t|
    t.text     "description", null: false
    t.integer  "goal_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "status_id"
  end

  add_index "action_goals", ["goal_id"], name: "index_action_goals_on_goal_id", using: :btree
  add_index "action_goals", ["status_id"], name: "index_action_goals_on_status_id", using: :btree

  create_table "characters", force: :cascade do |t|
    t.integer  "group_id",                   null: false
    t.boolean  "notify",     default: true,  null: false
    t.integer  "order",                      null: false
    t.boolean  "is_admin",   default: false, null: false
    t.integer  "user_id",                    null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "characters", ["group_id"], name: "index_characters_on_group_id", using: :btree
  add_index "characters", ["user_id"], name: "index_characters_on_user_id", using: :btree

  create_table "commontator_comments", force: :cascade do |t|
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "editor_type"
    t.integer  "editor_id"
    t.integer  "thread_id",                     null: false
    t.text     "body",                          null: false
    t.datetime "deleted_at"
    t.integer  "cached_votes_up",   default: 0
    t.integer  "cached_votes_down", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_comments", ["cached_votes_down"], name: "index_commontator_comments_on_cached_votes_down", using: :btree
  add_index "commontator_comments", ["cached_votes_up"], name: "index_commontator_comments_on_cached_votes_up", using: :btree
  add_index "commontator_comments", ["creator_id", "creator_type", "thread_id"], name: "index_commontator_comments_on_c_id_and_c_type_and_t_id", using: :btree
  add_index "commontator_comments", ["thread_id", "created_at"], name: "index_commontator_comments_on_thread_id_and_created_at", using: :btree

  create_table "commontator_subscriptions", force: :cascade do |t|
    t.string   "subscriber_type", null: false
    t.integer  "subscriber_id",   null: false
    t.integer  "thread_id",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_subscriptions", ["subscriber_id", "subscriber_type", "thread_id"], name: "index_commontator_subscriptions_on_s_id_and_s_type_and_t_id", unique: true, using: :btree
  add_index "commontator_subscriptions", ["thread_id"], name: "index_commontator_subscriptions_on_thread_id", using: :btree

  create_table "commontator_threads", force: :cascade do |t|
    t.string   "commontable_type"
    t.integer  "commontable_id"
    t.datetime "closed_at"
    t.string   "closer_type"
    t.integer  "closer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "commontator_threads", ["commontable_id", "commontable_type"], name: "index_commontator_threads_on_c_id_and_c_type", unique: true, using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "goals", force: :cascade do |t|
    t.date     "end_date",                          null: false
    t.string   "theme",                             null: false
    t.string   "type",                              null: false
    t.json     "type_specific_fields",              null: false
    t.integer  "character_id"
    t.integer  "group_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.text     "description",          default: "", null: false
  end

  add_index "goals", ["character_id"], name: "index_goals_on_character_id", using: :btree
  add_index "goals", ["group_id"], name: "index_goals_on_group_id", using: :btree
  add_index "goals", ["type"], name: "index_goals_on_type", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",                      null: false
    t.text     "description",  default: "", null: false
    t.string   "password",     default: "", null: false
    t.integer  "member_limit", default: 0,  null: false
    t.integer  "creator",                   null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "groups", ["creator"], name: "index_groups_on_creator", using: :btree
  add_index "groups", ["description"], name: "index_groups_on_description", using: :btree
  add_index "groups", ["name"], name: "index_groups_on_name", using: :btree

  create_table "likes", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "status_id",  null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "likes", ["status_id", "user_id"], name: "index_likes_on_status_id_and_user_id", unique: true, using: :btree
  add_index "likes", ["status_id"], name: "index_likes_on_status_id", using: :btree
  add_index "likes", ["user_id", "status_id"], name: "index_likes_on_user_id_and_status_id", unique: true, using: :btree
  add_index "likes", ["user_id"], name: "index_likes_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "recipient"
    t.text     "description", null: false
    t.text     "link",        null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "group_id"
    t.integer  "status_id"
  end

  add_index "notifications", ["group_id"], name: "index_notifications_on_group_id", using: :btree
  add_index "notifications", ["recipient"], name: "index_notifications_on_recipient", using: :btree
  add_index "notifications", ["status_id"], name: "index_notifications_on_status_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.text     "description",        default: "", null: false
    t.integer  "character_id",                    null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "likes_count",        default: 0,  null: false
    t.date     "verified_at",                     null: false
    t.integer  "group_id"
    t.integer  "goal_id"
    t.integer  "action_goal_id"
  end

  add_index "statuses", ["action_goal_id"], name: "index_statuses_on_action_goal_id", using: :btree
  add_index "statuses", ["character_id"], name: "index_statuses_on_character_id", using: :btree
  add_index "statuses", ["goal_id"], name: "index_statuses_on_goal_id", using: :btree
  add_index "statuses", ["group_id"], name: "index_statuses_on_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                      default: "", null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "last_checked_notification", default: 0,  null: false
    t.integer  "last_used_character",                    null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["slug"], name: "index_users_on_slug", unique: true, using: :btree

  add_foreign_key "action_goals", "goals"
  add_foreign_key "action_goals", "statuses"
  add_foreign_key "characters", "groups"
  add_foreign_key "characters", "users"
  add_foreign_key "goals", "characters"
  add_foreign_key "goals", "groups"
  add_foreign_key "likes", "statuses", on_delete: :cascade
  add_foreign_key "likes", "users", on_delete: :cascade
  add_foreign_key "notifications", "groups"
  add_foreign_key "notifications", "statuses"
  add_foreign_key "notifications", "users"
  add_foreign_key "statuses", "action_goals"
  add_foreign_key "statuses", "goals"
  add_foreign_key "statuses", "groups"
end
