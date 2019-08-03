class AddPhotosColumnToLocationsTable < ActiveRecord::Migration[5.2]
  def change
    add_column :locations, :photo_url, :string
  end
end
