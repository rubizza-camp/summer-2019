# :reek:UncommunicativeVariableName
# :reek:FeatureEnvy
# :reek:TooManyStatements
class CreateReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :reviews do |t|
      t.text 'comment'
      t.integer 'rating'
      t.integer 'user_id'
      t.integer 'bar_id'

      t.timestamps null: false
    end
  end
end
