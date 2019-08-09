class Comment < ActiveRecord::Base
  validates :raiting, presence: { message: 'Rate it!' }
  validates :text, presence: { message: 'Write a review!' }, if: :too_low_raiting
  belongs_to :user
  belongs_to :restaurant

  after_save :update_raiting
  def too_low_raiting
    raiting ? raiting < 3 : false
  end

  private

  def update_raiting
    restaurant.update(raiting: restaurant.comments.average(:raiting).round(2))
  end
end
