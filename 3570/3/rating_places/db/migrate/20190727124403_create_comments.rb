class CreateComments < ActiveRecord::Migration
  # :reek:UncommunicativeVariableName
  # :reek:FeatureEnvy
  # :reek:TooManyStatements
  def up
    create_table :comments do |t|
      t.text :text
      t.integer :rating
      t.integer :user_id
      t.integer :place_id
    end
  end

  def down
    drop_table :comments
  end
end
