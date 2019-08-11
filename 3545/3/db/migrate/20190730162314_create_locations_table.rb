# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateLocationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :attitude
      t.integer :longitude
      t.string :description
    end
  end
end
