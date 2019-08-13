# :reek:FeatureEnvy and :reek:TooManyStatements and :reek:UncommunicativeVariableName
class CreateReviewsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |column|
      column.integer :grade
      column.text :text
      column.timestamps
    end
  end
end
