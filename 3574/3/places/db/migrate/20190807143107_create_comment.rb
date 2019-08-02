# :reek:FeatureEnvy and :reek:TooManyStatements and :reek:UncommunicativeVariableName

class CreateComment < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :text, nul: false
      t.integer :rating, nul: false
      t.integer :user_id
      t.integer :restaurant_id
    end
  end
end
