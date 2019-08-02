# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.string :description, null: false
      t.integer :rating, null: false
    end
  end
end
