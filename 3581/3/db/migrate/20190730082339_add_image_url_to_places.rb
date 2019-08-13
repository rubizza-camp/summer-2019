class AddImageUrlToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :image_url, :string
  end
end
