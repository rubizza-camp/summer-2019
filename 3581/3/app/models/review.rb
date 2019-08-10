class Review < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  validates :grade, numericality: { only_integer: true }
  validates :grade, numericality: { equal_to_numbers: 1..5 }
  validates :text, presence: true, if: :negative_grade?

  def negative_grade?
    grade <= 2
  end

  def update_rating
    place.reviews.average(:grade).to_f.round(2)
  end
end
