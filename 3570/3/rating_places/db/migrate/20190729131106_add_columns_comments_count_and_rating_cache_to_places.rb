class AddColumnsCommentsCountAndRatingCacheToPlaces < ActiveRecord::Migration
  def change
    add_column :places, :comments_counter, :integer
    change_column :places, :rating, :float
  end
end
