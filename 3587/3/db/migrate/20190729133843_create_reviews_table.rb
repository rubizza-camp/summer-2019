# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    add_foreign_key :reviews, :shops
    add_foreign_key :reviews, :users
    create_table :reviews do |column|
      column.integer :grade
      column.text :text
      column.integer :shop_id
      column.integer :user_id
      column.timestamps
    end
  end
end
