class AddMarkToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :mark, :integer
  end
end
