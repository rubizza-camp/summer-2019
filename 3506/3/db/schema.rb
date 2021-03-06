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

# rubocop:disable all
ActiveRecord::Schema.define(version: 2019_07_28_134605) do

  create_table "restaurants", force: :cascade do |t|
    t.string "name"
    t.float "average_rating"
    t.text "description"
    t.string "address"
  end

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", null: false
    t.text "comment", null: false
    t.integer "user_id", null: false
    t.integer "restaurant_id", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "email", null: false
    t.string "password_hash", null: false
  end
end
# rubocop:enable all
