class CreatePlaces < ActiveRecord::Migration
  # :reek:UncommunicativeVariableName
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def up
    create_table :places do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.text :short_description
      t.text :description
      t.float :rating, default: 0.0
      t.integer :comments_count, default: 0
    end
  end

  def down
    drop_table :places
  end
end
