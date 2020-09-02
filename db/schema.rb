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

ActiveRecord::Schema.define(version: 2020_09_01_105615) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "channels", force: :cascade do |t|
    t.integer "chatroom_id"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "chatrooms", id: :serial, force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "relationship_id"
  end

  create_table "chatrooms_users", id: false, force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "chatroom_id", null: false
    t.index ["chatroom_id"], name: "index_chatrooms_users_on_chatroom_id"
    t.index ["user_id"], name: "index_chatrooms_users_on_user_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "content"
    t.integer "user_id"
    t.integer "chatroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chatroom_id"], name: "index_messages_on_chatroom_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "friend_id"
    t.integer "type_id"
    t.integer "chatroom_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "messages", "chatrooms"
  add_foreign_key "messages", "users"
end
