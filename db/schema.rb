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

ActiveRecord::Schema.define(version: 20150320072450) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "daily_goals", force: :cascade do |t|
    t.text     "description", default: "", null: false
    t.integer  "weekday",                  null: false
    t.integer  "user_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "daily_goals", ["user_id"], name: "index_daily_goals_on_user_id", using: :btree
  add_index "daily_goals", ["weekday"], name: "index_daily_goals_on_weekday", using: :btree

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

  create_table "monthly_goals", force: :cascade do |t|
    t.text     "description", default: "", null: false
    t.date     "season",                   null: false
    t.integer  "user_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "monthly_goals", ["season"], name: "index_monthly_goals_on_season", using: :btree
  add_index "monthly_goals", ["user_id"], name: "index_monthly_goals_on_user_id", using: :btree

  create_table "statuses", force: :cascade do |t|
    t.text     "description",        default: "", null: false
    t.integer  "user_id",                         null: false
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "likes_count",        default: 0,  null: false
    t.date     "verified_at",                     null: false
  end

  add_index "statuses", ["user_id"], name: "index_statuses_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                   default: "", null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "weekly_goals", force: :cascade do |t|
    t.text     "description", default: "", null: false
    t.date     "weeknum",                  null: false
    t.integer  "user_id",                  null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "weekly_goals", ["user_id"], name: "index_weekly_goals_on_user_id", using: :btree
  add_index "weekly_goals", ["weeknum"], name: "index_weekly_goals_on_weeknum", using: :btree

  add_foreign_key "likes", "statuses", on_delete: :cascade
  add_foreign_key "likes", "users", on_delete: :cascade
end
