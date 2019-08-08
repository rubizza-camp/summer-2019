# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateShopsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :shops do |t|
      t.text :name
      t.text :description
      t.text :address
      t.timestamps
    end
  end
end
