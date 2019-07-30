# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName

class CreateReviewTable < ActiveRecord::Migration[5.2]
  def change
    create_table :review do |t|
      t.string :text
      t.integer :user_id
      t.integer :restaurant_id
      t.integer :score
    end
  end
end
