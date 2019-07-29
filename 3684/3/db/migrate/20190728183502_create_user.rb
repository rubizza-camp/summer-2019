# :reek:FeatureEnvy
class CreateUser < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |table|
      table.string :name
      table.string :email
      table.string :password
    end
  end
end
