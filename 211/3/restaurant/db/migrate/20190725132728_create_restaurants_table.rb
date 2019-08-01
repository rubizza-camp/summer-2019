class CreateRestaurantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :location, null: false
      t.text :description
      t.string :photo
      t.timestamp
    end
  end
end
