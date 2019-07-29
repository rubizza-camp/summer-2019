class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :grade
      t.text :text
      t.integer :place_id
      t.integer :user_id
      t.timestamps
    end
  end
end
