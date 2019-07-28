#:reek:FeatureEnvy and :reek:UncommunicativeVariableName
class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :grade, null: false
      t.text :text
      t.timestamps
    end
  end
end
