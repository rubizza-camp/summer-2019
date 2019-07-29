# :reek:FeatureEnvy
# :reek:TooManyStatements
class ReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |review|
      review.integer :grade
      review.text :text
      review.integer :place_id
      review.integer :user_id
      review.timestamps
    end
  end
end
