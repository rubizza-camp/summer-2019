# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName

class CreatePlacesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :location
      t.string :name
      t.float :score
      t.string :description
    end
  end
end
