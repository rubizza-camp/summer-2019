# :reek:FeatureEnvy
# :reek:UncommunicativeVariableName
class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.string :title
      t.integer :rating
      t.integer :user_id
      t.integer :place_id
    end
  end
end
