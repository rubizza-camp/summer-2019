#:reek:FeatureEnvy and :reek:TooManyStatements
class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |ttt|
      ttt.belongs_to :shop, index: true
      ttt.belongs_to :user, index: true
      ttt.text :comment
      ttt.integer :rating

      ttt.timestamps
    end
  end
end
