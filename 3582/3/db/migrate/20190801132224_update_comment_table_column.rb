class UpdateCommentTableColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :restaraunt_id, :restaurant_id
  end
end
