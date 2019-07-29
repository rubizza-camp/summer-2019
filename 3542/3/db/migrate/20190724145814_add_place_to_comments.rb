class AddPlaceToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :place, foreign_key: true
  end
end
