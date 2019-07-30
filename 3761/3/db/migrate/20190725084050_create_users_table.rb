# :reek:FeatureEnvy
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |column|
      column.string :name, null: false
      column.string :email, null: false
      column.string :password_hash, null: false
      column.timestamps
    end
  end
end
