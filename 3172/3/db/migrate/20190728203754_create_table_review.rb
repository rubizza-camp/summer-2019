# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
class CreateTableReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text       :text, null: false
      t.integer    :rating, null: false
      t.references :user, foreign_key: true, index: true, null: false
      t.references :place, foreign_key: true, index: true, null: false
      t.timestamps
    end
  end
end
