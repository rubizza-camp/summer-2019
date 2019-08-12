# :reek:FeatureEnvy and :reek:TooManyStatements and :reek:UncommunicativeVariableName

class CreateRestaurant < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name, nul: false
      t.text :description, nul: false
      t.string :coordinate, nul: false
    end
  end
end
