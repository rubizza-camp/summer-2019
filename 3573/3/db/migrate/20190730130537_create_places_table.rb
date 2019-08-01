class CreatePlacesTable < ActiveRecord::Migration[5.2]
  def up
    create_table :places do |p|
      p.string :name
      p.string :rating
      p.string :address
      p.string :image_url
      p.string :description
      p.string :short_description
      p.string :timestamps
    end
  end
end
