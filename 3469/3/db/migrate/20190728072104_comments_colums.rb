# rubocop:disable all
class CommentsColums < ActiveRecord::Migration[5.2]
 def change
    add_column :comments, :user_id, :integer
    add_column :comments, :place_id, :integer
end
end
