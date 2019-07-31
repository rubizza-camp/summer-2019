# :reek:FeatureEnvy
class CreateShopsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |column|
      column.text :name
      column.text :description
      column.text :address
      column.timestamps
    end
  end
end
