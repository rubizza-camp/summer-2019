class CreateRestaurant < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :short_description
      t.string :long_description
      t.string :image_path
      t.string :address
      t.float :rating
    end
  end
end
