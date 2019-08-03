# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateRestaurant < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |table|
      table.string :location
      table.string :name
      table.string :short_description
      table.string :full_description
      table.float :score
    end
  end
end
