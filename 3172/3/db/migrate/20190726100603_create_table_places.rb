class CreateTablePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.text :name
      t.text :description
      t.text :locations
    end
  end
end
