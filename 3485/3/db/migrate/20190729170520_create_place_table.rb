# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName

class CreatePlaceTable < ActiveRecord::Migration[5.2]
  def change
    create_table :place do |t|
      t.string :location
      t.string :name
      t.float :score
    end
  end
end
