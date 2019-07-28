class Review < ActiveRecord::Base
  BORDER_GRADE_VALUE = 3

  belongs_to :user
  belongs_to :place
  validates :text, presence: true, length: { minimum: 20 }, if: :bad_review?
  validates_presence_of :grade

  def bad_review?
    grade <= BORDER_GRADE_VALUE
  end
end