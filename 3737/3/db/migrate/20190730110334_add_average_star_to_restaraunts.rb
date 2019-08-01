class AddAverageStarToRestaraunts < ActiveRecord::Migration[5.2]
  def change
    add_column :restaraunts, :average_star, :float
  end
end
