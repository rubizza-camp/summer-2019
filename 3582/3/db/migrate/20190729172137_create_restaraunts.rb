# :reek:FeatureEnvy :reek:UncommunicativeVariableName
class CreateRestaraunts < ActiveRecord::Migration[5.0]
  def change
    create_table :restaraunts do |t|
      t.string :name
      t.string :location
      t.string :description
    end
  end
end
