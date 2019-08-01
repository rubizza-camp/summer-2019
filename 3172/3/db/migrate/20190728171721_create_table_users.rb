# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateTableUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.string :password_digest, null: false
    end
    add_index :users, :email, unique: true
  end
end
