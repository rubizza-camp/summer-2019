#:reek:FeatureEnvy
#:reek:TooManyStatements
#:reek:UncommunicativeVariableName
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string  :username, null: false
      t.string  :pass_hash, null: false
      t.string  :mail, null: false
      t.string  :first_name, null: false
      t.string  :last_name

      t.timestamps
    end
  end
end
