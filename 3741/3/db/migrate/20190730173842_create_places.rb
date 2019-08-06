# frozen_string_literal: true

# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
# :reek:TooManyStatements
class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :short_info
      t.text :description
      t.float :lat, null: false
      t.float :lon, null: false
      t.timestamps
    end
  end
end
