# :reek:FeatureEnvy and :reek:TooManyStatements and :reek:UncommunicativeVariableName
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |column|
      column.string :name
      column.string :email, null: false
      column.string :password_hash, null: false
      column.timestamps
    end
  end
end
