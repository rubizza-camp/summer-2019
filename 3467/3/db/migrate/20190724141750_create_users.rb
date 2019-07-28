#:reek:FeatureEnvy
class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |ttt|
      ttt.text :name
      ttt.text :email, index: { unique: true }
      ttt.text :password_hash

      ttt.timestamps
    end
  end
end
