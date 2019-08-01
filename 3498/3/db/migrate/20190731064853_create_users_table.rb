class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |item|
      item.string :name
      item.string :email
      item.string :password_hash
    end
  end
end
