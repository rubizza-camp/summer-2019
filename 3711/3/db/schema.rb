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

# rubocop:disable Style/NumericLiterals
# rubocop:disable Metrics/BlockLength
ActiveRecord::Schema.define(version: 2019_07_28_132511) do
  create_table 'places', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'note', null: false
    t.text 'description'
    t.float 'longitude', null: false
    t.float 'latitude', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'place_id', null: false
    t.integer 'user_id', null: false
    t.integer 'rating', null: false
    t.text 'text'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username', null: false
    t.string 'pass_hash', null: false
    t.string 'mail', null: false
    t.string 'first_name', null: false
    t.string 'last_name'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/BlockLength
