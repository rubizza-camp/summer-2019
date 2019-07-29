class CreateUsersTable < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.string :login
      t.string :email
      t.string :password_digest
      t.timestamp
    end
  end

  def down
    drop_table :users
  end
end
