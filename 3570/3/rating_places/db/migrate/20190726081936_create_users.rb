require 'sinatra/activerecord'

class CreateUsers < ActiveRecord::Migration
  # :reek:UncommunicativeVariableName
  # :reek:FeatureEnvy
  def up
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_digest
    end
  end

  def down
    drop_table :users
  end
end
