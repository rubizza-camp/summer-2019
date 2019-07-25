class AddColumnsToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :user_id, :integer
    add_column :reviews, :place_id, :integer
  end
end
