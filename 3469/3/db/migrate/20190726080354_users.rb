# :reek:FeatureEnvy and :reek:UncommunicativeVariableName
class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
      t.timestamps
    end
  end
end
