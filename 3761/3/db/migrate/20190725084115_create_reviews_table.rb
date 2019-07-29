# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |column|
      column.integer :grade
      column.text :text
      column.integer :place_id
      column.integer :user_id
      column.timestamps
    end
  end
end
