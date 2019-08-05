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
ActiveRecord::Schema.define(version: 20_190_724_141_750) do
  create_table 'reviews', force: :cascade do |t|
    t.integer  'shop_id'
    t.integer  'user_id'
    t.text     'comment'
    t.integer  'rating'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'reviews', ['shop_id'], name: 'index_reviews_on_shop_id'
  add_index 'reviews', ['user_id'], name: 'index_reviews_on_user_id'

  create_table 'shops', force: :cascade do |t|
    t.text     'name'
    t.text     'description'
    t.text     'address'
    t.float    'rating'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'users', force: :cascade do |t|
    t.text     'name'
    t.text     'email'
    t.text     'password_hash'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  add_index 'users', ['email'], name: 'index_users_on_email', unique: true
end
# rubocop:enable Metrics/BlockLength
