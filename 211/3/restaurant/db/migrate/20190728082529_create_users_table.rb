class CreateUsersTable < ActiveRecord::Migration[5.2]
  def up
    create_table :users do |t|
      t.string :login, null: false, index: {unique: true}
      t.string :email, null: false, index: {unique: true}
      t.string :password_digest
      t.timestamp
    end
  end

  def down
    drop_table :users
  end
end
