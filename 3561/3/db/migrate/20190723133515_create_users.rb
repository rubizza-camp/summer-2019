# frozen_string_literal: true

#:reek:FeatureEnvy and :reek:UncommunicativeVariableName

# migration for users
class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, index: { unique: true }
      t.string :password_hash
    end
  end
end
