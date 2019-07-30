class CreateCommentTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy and :reek:UncommunicativeVariableName
  def change
    create_table :comments do |t|
      t.string :text
      t.integer :star
      t.integer :user_id
      t.integer :restaraunt_id
    end
  end
end
