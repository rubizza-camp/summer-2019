# :reek:FeatureEnvy
class CreateComment < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |table|
      table.string :text
      table.integer :user_id
      table.integer :restaurant_id
      table.integer :score
    end
  end
end
