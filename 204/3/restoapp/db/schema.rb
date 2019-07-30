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

ActiveRecord::Schema.define(version: 20_190_725_163_744) do
  create_table 'accounts', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'password', null: false
    t.string 'email', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'restraunts', force: :cascade do |t|
    t.string 'title', null: false
    t.string 'description', null: false
    t.string 'google_map_link', null: false
    t.integer 'avg_rate', default: 0
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'reviews', force: :cascade do |t|
    t.string 'body', null: false
    t.integer 'rate', null: false
    t.integer 'account_id', null: false
    t.integer 'restraunt_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end
end
