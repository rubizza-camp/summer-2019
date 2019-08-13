# :reek:FeatureEnvy and :reek:TooManyStatements and :reek:UncommunicativeVariableName
class CreatePlacesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |column|
      column.string :name
      column.string :location
      column.string :short_description
      column.text :full_description
      column.timestamps
    end
  end
end
