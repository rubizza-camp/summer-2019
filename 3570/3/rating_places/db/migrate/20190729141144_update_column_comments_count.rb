class UpdateColumnCommentsCount < ActiveRecord::Migration
  def change
    rename_column :places, :comments_counter, :comments_count
  end
end
