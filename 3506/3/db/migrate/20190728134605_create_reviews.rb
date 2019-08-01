#:reek:all
class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :comment, null: false
      t.integer :user_id, null: false
      t.integer :restaurant_id, null: false
    end
  end
end
