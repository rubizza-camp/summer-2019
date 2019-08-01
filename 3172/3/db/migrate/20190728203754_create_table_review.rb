# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
class CreateTableReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text       :text, null: false
      t.integer    :rating, null: false
      t.integer    :user_id, null: false
      t.references :place, foreign_key: true
      t.timestamps
    end
  end
end
