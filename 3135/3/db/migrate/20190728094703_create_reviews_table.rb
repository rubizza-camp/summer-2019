class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :rating, null: false
      t.text :description
      t.references(:user)
      t.references(:restaurant)
    end
  end
end
