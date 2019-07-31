# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName

class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.string :text
      t.integer :users_id
      t.integer :restaurant_id
      t.integer :score
    end
  end
end
