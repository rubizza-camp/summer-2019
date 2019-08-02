# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateCommentariesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :commentaries do |t|
      t.integer :location_id
      t.integer :user_id
      t.string :text
      t.integer :points
    end
  end
end
