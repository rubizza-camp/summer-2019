# frozen_string_literal: true

#:reek:FeatureEnvy and :reek:UncommunicativeVariableName and :reek:TooManyStatements

# migration for places
class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.string :short_description
      t.string :description
      t.string :image_url
      t.string :address
      t.float :rating
    end
  end
end
