class CreatePlaces < ActiveRecord::Migration
  # :reek:UncommunicativeVariableName
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def up
    create_table :places do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.text :description
      t.integer :rating
    end
  end

  def down
    drop_table :places
  end
end
