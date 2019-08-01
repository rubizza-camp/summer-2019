#:reek:all
class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :place_name
      t.integer :place_rating
      t.string :description
      t.string :location
    end
  end
end
