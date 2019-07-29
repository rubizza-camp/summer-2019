class AddPathToImageToPlaces < ActiveRecord::Migration[5.2]
  def change
    add_column :places, :path_to_image, :string
  end
end
