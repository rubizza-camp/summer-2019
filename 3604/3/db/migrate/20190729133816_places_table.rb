# :reek:FeatureEnvy
# :reek:TooManyStatements
class PlacesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |place|
      place.string :name
      place.string :location
      place.text :main_description
      place.text :full_description
      place.timestamps
    end
  end
end
