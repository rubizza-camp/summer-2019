#:reek:FeatureEnvy
#:reek:UncommunicativeVariableName

class CreateReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.integer :grade, null: false
      t.text :text
      t.timestamps
    end
  end
end
