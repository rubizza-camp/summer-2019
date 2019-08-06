class AddReviewRefToUser < ActiveRecord::Migration[5.2]
  def change
    add_reference :reviews, :user, foreign_key: true
  end
end
