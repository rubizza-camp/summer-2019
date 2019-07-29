# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreatePlacesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |column|
      column.string :name
      column.string :location
      column.text :main_description
      column.text :full_description
      column.timestamps
    end
  end
end
