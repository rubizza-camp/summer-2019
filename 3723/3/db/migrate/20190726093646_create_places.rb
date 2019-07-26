class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name
      t.string :location
      t.string :description
      t.integer :rating
    end
  end
end
