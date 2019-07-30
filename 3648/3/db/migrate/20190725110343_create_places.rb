class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :place_name
      t.string :location
      t.integer :place_rating
      t.text :description

      t.timestamps
    end
  end
end
