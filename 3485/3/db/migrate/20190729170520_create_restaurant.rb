# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateRestaurant < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |table|
      table.string :location
      table.string :name
      table.text :description
      table.float :score
    end
  end
end
