class CreatePlacesTable < ActiveRecord::Migration[5.2]
  def change
  	 create_table :places do |t|
      t.string :name
      t.string :address
      t.string :location
      t.string :description
      t.float :rating
    end
  end
end
