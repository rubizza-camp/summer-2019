# :reek:FeatureEnvy
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |table|
      table.string :name, null: false
      table.string :email, null: false
      table.string :password_hash, null: false
      table.timestamps
    end
  end
end
