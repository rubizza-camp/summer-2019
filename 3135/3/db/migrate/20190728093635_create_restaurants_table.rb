# :reek:FeatureEnvy:
# :reek:IrresponsibleModule:
# :reek:UncommunicativeVariableName:
class CreateRestaurantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description, null: false
      t.string :location, null: false
    end
  end
end
