# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |table|
      table.string :name, null: false
      table.float :latitude, null: false
      table.float :longitude, null: false
      table.text :description
      table.timestamps
    end
  end
end
