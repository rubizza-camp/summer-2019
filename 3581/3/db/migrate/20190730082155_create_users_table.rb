#:reek:all
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |column|
      column.string :name
      column.string :email
      column.string :password_hash
      column.timestamps
    end
  end
end
