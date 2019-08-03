class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :comment, null: false
      t.integer :user_id
      t.integer :post_id
      t.float :star

      t.timestamps
    end
  end
end
