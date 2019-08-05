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
ActiveRecord::Schema.define(version: 2019_08_03_115800) do
  # rubocop:enable Style/NumericLiterals
  create_table 'comments', force: :cascade do |t|
    t.integer 'grade', null: false
    t.text 'text', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id'
    t.integer 'restaurant_id'
  end

  create_table 'restaurants', force: :cascade do |t|
    t.string 'name'
    t.string 'address'
    t.text 'short_description'
    t.text full_description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'email', null: false
    t.string 'password', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
