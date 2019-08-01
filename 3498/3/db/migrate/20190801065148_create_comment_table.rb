class CreateCommentTable < ActiveRecord::Migration[5.2]
  def change
  	create_table :comments do |item|
      item.integer :rating
      item.text :text
      item.integer :user_id
      item.integer :place_id
    end
  end
end
