class CreateUsersTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy
  def change
    create_table :users do |user|
      user.string :name
      user.string :email
      user.string :password_hash
      user.string :timestamps
    end
  end
end
