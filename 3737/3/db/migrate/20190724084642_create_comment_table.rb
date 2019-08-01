class CreateCommentTable < ActiveRecord::Migration[5.2]
  #:reek:FeatureEnvy and :reek:UncommunicativeVariableName
  def change
    create_table :comments do |t|
      t.string :text, nul: false
      t.integer :star, nul: false
      t.integer :user_id
      t.integer :restaraunt_id
    end
  end
end
