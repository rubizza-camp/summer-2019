class CreateReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :title
      t.string :text
      t.float :rating
      t.references :user, foreign_key: true
        add_foreign_key :reviews, :users, foreign_key: true
      t.references :restaurant, foreign_key: true
        add_foreign_key :reviews, :restaurants, foreign_key: true
    end
  end
end
