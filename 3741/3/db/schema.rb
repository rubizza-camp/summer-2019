# frozen_string_literal: true

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
ActiveRecord::Schema.define(version: 20_190_730_174_656) do
  create_table 'places', force: :cascade do |t|
    t.string 'name', null: false
    t.text 'short_info'
    t.text 'description'
    t.float 'lat', null: false
    t.float 'lon', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reviews', force: :cascade do |t|
    t.integer 'stars', null: false
    t.text 'comment'
    t.integer 'user_id', null: false
    t.integer 'place_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['place_id'], name: 'index_reviews_on_place_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'username', null: false
    t.string 'email', null: false
    t.string 'password_hash', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
  end
end
# rubocop:enable Metrics/BlockLength