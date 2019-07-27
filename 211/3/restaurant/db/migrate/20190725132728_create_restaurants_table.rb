class CreateRestaurantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.text :description
      t.string :photo
      t.datetime :created_at
      t.datetime :updated_at
    end
  end
end
