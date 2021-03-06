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
# rubocop:disable Metrics/BlockLength
# rubocop:disable Style/NumericLiterals
ActiveRecord::Schema.define(version: 2019_07_26_125759) do
  create_table 'places', force: :cascade do |t|
    t.string 'name'
    t.string 'location'
    t.text 'main_description'
    t.text 'full_description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'path_to_image'
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'grade', null: false
    t.text 'text', null: false
    t.integer 'place_id'
    t.integer 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'password_hash', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['name'], name: 'index_users_on_name', unique: true
  end
end
# rubocop:enable Style/NumericLiterals
# rubocop:enable Metrics/BlockLength
