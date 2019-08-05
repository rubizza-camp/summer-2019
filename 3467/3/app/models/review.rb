class Review < ActiveRecord::Base
  RATING_ABOVE_WHICH_NO_COMMENT_IS_NEEDED = 5

  belongs_to :shop
  belongs_to :user
  validates :rating, presence: true
  validates :comment, presence: true, unless: :like?

  def like?
    rating ? rating >= RATING_ABOVE_WHICH_NO_COMMENT_IS_NEEDED : false
  end
end
