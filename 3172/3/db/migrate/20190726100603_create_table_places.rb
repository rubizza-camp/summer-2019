# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateTablePlaces < ActiveRecord::Migration[5.2]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :description, null: false
      t.string :locations, null: false
      t.integer :reviews_count
    end
  end
end
