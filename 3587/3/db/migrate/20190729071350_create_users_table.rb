# :reek:FeatureEnvy
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |column|
      column.text :name
      column.text :email
      column.text :password_hash
    end
  end
end
