# frozen_string_literal: true

# :reek:FeatureEnvy and :reek:TooManyStatements and :reek:UncommunicativeVariableName

class Users < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.timestamps
    end
  end
end
