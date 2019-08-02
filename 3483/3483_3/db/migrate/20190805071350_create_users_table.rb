#:reek:FeatureEnvy
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |ttt|
      ttt.text :name
      ttt.text :email
      ttt.text :password_hash
    end
  end
end
