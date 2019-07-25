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

ActiveRecord::Schema.define(version: 2019_07_23_151719) do

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.string "short_description"
    t.string "long_description"
    t.string "image_path"
    t.string "address"
    t.float "rating"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title"
    t.string "text"
    t.float "rating"
    t.integer "user_id"
    t.integer "restaurant_id"
    t.index ["restaurant_id"], name: "index_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", default: "Guest"
    t.string "email"
    t.string "password"
  end
end
