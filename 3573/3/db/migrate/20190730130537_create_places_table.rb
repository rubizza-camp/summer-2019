class CreatePlacesTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy
  #:reek:TooManyStatements
  def change
    create_table :places do |place|
      place.string :name
      place.string :rating
      place.string :address
      place.string :image_url
      place.string :description
      place.string :short_description
      place.string :timestamps
    end
  end
end
