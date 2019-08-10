class AddReferencesToReviews < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :shops, foreign_key: true
    add_reference :reviews, :users, foreign_key: true
  end
end
