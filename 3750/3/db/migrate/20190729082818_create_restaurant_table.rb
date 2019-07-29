#:reek:FeatureEnvy
#:reek:UncommunicativeVariableName
#:reek:TooManyStatements

class CreateRestaurantTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :short_description
      t.text :description
      t.timestamps
    end
  end
end
