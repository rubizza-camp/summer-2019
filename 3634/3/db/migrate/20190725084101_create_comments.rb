# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |table|
      table.integer :mark, null: false
      table.text :body
      table.timestamps
    end
  end
end
