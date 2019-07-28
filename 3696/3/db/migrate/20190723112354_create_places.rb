#:reek:FeatureEnvy and :reek:UncommunicativeVariableName and :reek:TooManyStatements
class CreatePlaces < ActiveRecord::Migration
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.float :latitude, null: false
      t.float :longitude, null: false
      t.text :short_description
      t.text :full_description
      t.timestamps
    end
  end
end
