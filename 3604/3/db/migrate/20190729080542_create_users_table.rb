# :reek:FeatureEnvy
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |user|
      user.string :name
      user.string :email
      user.string :password_hash
      user.timestamps
    end
  end
end
