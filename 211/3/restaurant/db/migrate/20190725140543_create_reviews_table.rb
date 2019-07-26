class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :reviews do |t|
      t.text :description
      t.integer :user_id
      t.integer :restaurant_id

      t.datetime :created_at
      t.datetime :updated_at
    end  	
  end
end
