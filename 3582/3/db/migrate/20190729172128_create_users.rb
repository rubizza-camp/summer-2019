# :reek:FeatureEnvy :reek:UncommunicativeVariableName
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :name, index: { unique: true }
      t.string :email, index: { unique: true }
      t.string :password
    end
  end
end
