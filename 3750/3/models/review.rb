class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  validates :text, presence: true, length: { minimum: 20 }, if: :bad_review?
  validates_presence_of :grade

  def bad_review?
    stars = 2
    grade <= stars
  end
end
