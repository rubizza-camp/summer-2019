class AddIndexesToUsers < ActiveRecord::Migration[5.2]
  def change
    add_index :users, :name
    add_index :users, :email, unique: true
  end
end
