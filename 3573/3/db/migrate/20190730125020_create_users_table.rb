class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |u|
      u.string :name
      u.string :email
      u.string :password_hash
      u.string :timestamps
    end
  end
end
