# :reek:FeatureEnvy :reek:UncommunicativeVariableName :reek:TooManyStatements
class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.string :content
      t.float :rating
      t.references :user, foreign_key: true
      add_foreign_key :comments, :users, foreign_key: true
      t.references :restaraunts, foreign_key: true
      add_foreign_key :restaraunts, foreign_key: true
    end
  end
end
