# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email,                 null: false, unique: true
      t.string :password_digest,       null: false

      t.timestamps null: false
    end
  end
end
