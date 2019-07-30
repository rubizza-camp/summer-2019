class CreateRestarauntTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy and :reek:UncommunicativeVariableName
  def change
    create_table :restaraunts do |t|
      t.string :name
      t.text :description
      t.string :coordinate
    end
  end
end
