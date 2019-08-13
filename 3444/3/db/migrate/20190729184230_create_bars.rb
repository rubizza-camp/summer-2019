# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateBars < ActiveRecord::Migration[5.2]
  def change
    create_table :bars do |t|
      t.string 'title'
      t.string 'short_description'
      t.text 'full_description'
      t.text 'coordinates'

      t.timestamps null: false
    end
  end
end
