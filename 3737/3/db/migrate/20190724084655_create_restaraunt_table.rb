class CreateRestarauntTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy and :reek:UncommunicativeVariableName
  def change
    create_table :restaraunts do |t|
      t.string :name, nul: false
      t.text :description, nul: false
      t.string :coordinate, nul: false
    end
  end
end
