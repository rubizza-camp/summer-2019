# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |table|
      table.integer :mark, null: false
      table.text :annotation, null: false
      table.integer :user_id, null: false
      table.integer :restaurant_id, null: false
      table.timestamps
    end
  end
end
