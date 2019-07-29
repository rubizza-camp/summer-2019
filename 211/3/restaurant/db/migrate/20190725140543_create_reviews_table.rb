class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text :description
      t.integer :mark
      t.integer :user_id, index: true
      t.integer :restaurant_id, index: true

      t.timestamp
    end
  end
end
