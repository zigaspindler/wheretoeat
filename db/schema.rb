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

ActiveRecord::Schema.define(version: 20161220151019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "comments", force: :cascade do |t|
    t.string   "text"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
    t.index ["group_id"], name: "index_comments_on_group_id", using: :btree
    t.index ["user_id"], name: "index_comments_on_user_id", using: :btree
  end

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.string   "sr_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "groups_restaurants", force: :cascade do |t|
    t.integer "group_id",      null: false
    t.integer "restaurant_id", null: false
    t.index ["group_id", "restaurant_id"], name: "index_groups_restaurants_on_group_id_and_restaurant_id", using: :btree
    t.index ["restaurant_id", "group_id"], name: "index_groups_restaurants_on_restaurant_id_and_group_id", using: :btree
  end

  create_table "menus", force: :cascade do |t|
    t.string   "description"
    t.date     "date"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.float    "price"
    t.boolean  "regular"
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id", using: :btree
  end

  create_table "restaurants", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.float    "default_price"
    t.string   "telephone_number"
    t.string   "menu_link"
    t.string   "kamjest_id"
    t.string   "menu_parser"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "username"
    t.hstore   "settings"
    t.integer  "shortreckonings_id"
    t.integer  "group_id"
    t.boolean  "admin",                  default: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["group_id"], name: "index_users_on_group_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["username"], name: "index_users_on_username", unique: true, using: :btree
  end

  create_table "votes", force: :cascade do |t|
    t.date     "date"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "group_id"
    t.integer  "menu_id"
    t.index ["group_id"], name: "index_votes_on_group_id", using: :btree
    t.index ["menu_id"], name: "index_votes_on_menu_id", using: :btree
    t.index ["restaurant_id"], name: "index_votes_on_restaurant_id", using: :btree
    t.index ["user_id"], name: "index_votes_on_user_id", using: :btree
  end

  add_foreign_key "comments", "groups"
  add_foreign_key "comments", "users"
  add_foreign_key "menus", "restaurants"
  add_foreign_key "users", "groups"
  add_foreign_key "votes", "groups"
  add_foreign_key "votes", "menus"
  add_foreign_key "votes", "restaurants"
  add_foreign_key "votes", "users"
end
