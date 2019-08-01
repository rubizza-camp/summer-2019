# :reek:FeatureEnvy :reek:UncommunicativeVariableName :reek:TooManyStatements
class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :rating
      t.integer :restaraunt_id
      t.integer :user_id
    end
  end
end
