# :reek:FeatureEnvy
# :reek:TooManyStatements
# :reek:UncommunicativeVariableName
class CreateTableReview < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text       :text
      t.integer    :rating
      t.integer    :author
      t.references :place, foreign_key: true
      t.timestamps
    end
  end
end
