#:reek:FeatureEnvy and :reek:TooManyStatements
class CreateShops < ActiveRecord::Migration
  def change
    create_table :shops do |ttt|
      ttt.text :name
      ttt.text :description
      ttt.text :address
      ttt.float :rating

      ttt.timestamps
    end
  end
end
