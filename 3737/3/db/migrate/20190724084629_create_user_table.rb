class CreateUserTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy and :reek:UncommunicativeVariableName
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_hash
    end
  end
end
