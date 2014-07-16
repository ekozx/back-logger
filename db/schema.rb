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

ActiveRecord::Schema.define(version: 20140712234421) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "associations", force: true do |t|
    t.integer  "backlog_id"
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "associations", ["backlog_id", "entry_id"], name: "index_associations_on_backlog_id_and_entry_id", unique: true, using: :btree
  add_index "associations", ["backlog_id"], name: "index_associations_on_backlog_id", using: :btree
  add_index "associations", ["entry_id"], name: "index_associations_on_entry_id", using: :btree

  create_table "backlogs", force: true do |t|
    t.integer  "user_id"
    t.integer  "entry_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "entries_id"
  end

  add_index "backlogs", ["entries_id"], name: "index_backlogs_on_entries_id", using: :btree

  create_table "entries", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "photo"
    t.integer  "backlogs_id"
    t.integer  "backlog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "thumbnail_file_name"
    t.string   "thumbnail_content_type"
    t.integer  "thumbnail_file_size"
    t.datetime "thumbnail_updated_at"
  end

  add_index "entries", ["backlog_id"], name: "index_entries_on_backlog_id", using: :btree

  create_table "friendships", id: false, force: true do |t|
    t.integer "user_id"
    t.integer "friend_user_id"
  end

  add_index "friendships", ["friend_user_id", "user_id"], name: "index_friendships_on_friend_user_id_and_user_id", unique: true, using: :btree
  add_index "friendships", ["user_id", "friend_user_id"], name: "index_friendships_on_user_id_and_friend_user_id", unique: true, using: :btree

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id", using: :btree
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true, using: :btree
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id", using: :btree

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true, using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.integer  "backlog_id"
    t.string   "nickname",                            null: false
    t.string   "name",                   default: ""
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "uid"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
