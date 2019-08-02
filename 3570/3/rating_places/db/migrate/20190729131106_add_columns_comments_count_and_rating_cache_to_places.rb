class AddColumnsCommentsCountAndRatingCacheToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :comments_counter, :integer, default: 0
    change_column :places, :rating, :float, default: 0.0
  end
end
