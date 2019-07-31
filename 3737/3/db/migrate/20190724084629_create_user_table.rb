class CreateUserTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy and :reek:UncommunicativeVariableName
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false
      t.string :password_hash, null: false
    end
  end
end
