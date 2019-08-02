# frozen_string_literal: true

#:reek:FeatureEnvy and :reek:UncommunicativeVariableName and :reek:TooManyStatements

# migration for comments
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :star
      t.integer :user_id
      t.integer :place_id
    end
  end
end
