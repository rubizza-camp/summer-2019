#:reek:all
class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.float :average_rating
      t.text :description
      t.string :address
    end
  end
end
