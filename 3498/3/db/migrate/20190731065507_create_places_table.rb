# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreatePlacesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |item|
      item.string :name
      item.string :address
      item.string :location
      item.string :description
      item.float :rating
    end
  end
end
