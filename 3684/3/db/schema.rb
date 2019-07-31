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

ActiveRecord::Schema.define(version: 20_190_728_183_502) do
  create_table 'comments', force: :cascade do |t|
    t.string 'text'
    t.integer 'user_id'
    t.integer 'restaurant_id'
    t.integer 'score'
  end

  create_table 'restaurants', force: :cascade do |t|
    t.string 'location'
    t.string 'name'
    t.string 'short_description'
    t.string 'full_description'
    t.float 'score', default: 0.0
  end

  create_table 'users', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.string 'password'
  end
end
