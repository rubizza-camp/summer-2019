# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateComment < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |table|
      table.text :text
      table.references :user, foreign_key: true
      table.references :restaurant, foreign_key: true
      table.integer :raiting
      table.timestamp :created_at
    end
  end
end
