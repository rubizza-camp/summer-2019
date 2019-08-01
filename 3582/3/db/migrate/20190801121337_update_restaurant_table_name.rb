class UpdateRestaurantTableName < ActiveRecord::Migration[5.2]
  def change
    rename_table :restaraunts, :restaurants
  end
end
