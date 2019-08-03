# rubocop:disable Style/StringLiterals
ActiveRecord::Schema.define(version: 2019_08_01_194853) do
  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "summary"
    t.text "body"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.string "comment"
    t.integer "user_id"
    t.integer "post_id"
    t.float "star"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "password_hash", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
# rubocop:enable Style/StringLiterals
