class Comment < ActiveRecord::Base
  validates :raiting, presence: { message: 'Rate it!' }
  validates :text, presence: { message: 'Write a review!' }, if: :too_low_raiting
  belongs_to :user
  belongs_to :restaurant

  def too_low_raiting
    raiting ? raiting < 3 : false
  end
end
