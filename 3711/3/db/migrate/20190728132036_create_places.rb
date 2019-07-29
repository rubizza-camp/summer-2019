class CreatePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string  :name, null: false
      t.string  :note, null: false
      t.text    :description
      t.float   :longitude, null: false
      t.float   :latitude, null: false

      t.timestamps
    end
  end
end
