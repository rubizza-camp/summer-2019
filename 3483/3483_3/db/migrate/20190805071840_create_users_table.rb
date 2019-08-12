# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.text :name
      t.text :email
      t.text :password_hash
    end
  end
end
