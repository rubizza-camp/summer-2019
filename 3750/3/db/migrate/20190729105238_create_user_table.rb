#:reek:FeatureEnvy
#:reek:UncommunicativeVariableName

class CreateUserTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login, index: { unique: true }
      t.string :password_hash
      t.string :email, index: { unique: true }
      t.timestamps
    end
  end
end
