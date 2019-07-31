# :reek:FeatureEnvy:
# :reek:IrresponsibleModule:
# :reek:UncommunicativeVariableName:
class CreateUsersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :email, null: false, index: { unique: true }
      t.string :password_digest, null: false
    end
  end
end
