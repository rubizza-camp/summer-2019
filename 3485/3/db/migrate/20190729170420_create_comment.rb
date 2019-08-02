# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateComment < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |table|
      table.string :text
      table.integer :user_id
      table.integer :restaurant_id
      table.integer :score
      table.timestamp :created_at
    end
  end
end
