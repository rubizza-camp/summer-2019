# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |ttt|
      ttt.integer :grade
      ttt.text :text
      ttt.integer :place_id
      ttt.integer :user_id
      ttt.timestamps
    end
  end
end
