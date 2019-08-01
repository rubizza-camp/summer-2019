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

ActiveRecord::Schema.define(version: 2019_07_30_130537) do

  create_table "comments", force: :cascade do |t|
    t.string "text"
    t.string "star"
    t.string "place_id"
    t.string "user_id"
    t.string "timestamps"
  end

  create_table "places", force: :cascade do |t|
    t.string "name"
    t.string "rating"
    t.string "address"
    t.string "image_url"
    t.string "description"
    t.string "short_description"
    t.string "timestamps"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_hash"
    t.string "timestamps"
  end

end
