class Restaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
    t.string :name
    t.string :short_description
    t.string :full_description
    t.string :logo
    t.float :rating
    end
  end
end