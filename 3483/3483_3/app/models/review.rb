class Review < ActiveRecord::Base
  MAX_RATING = 5
  belongs_to :user
  belongs_to :shop
  validates :text, :grade, presence: true
  validates :grade, inclusion: { in: 1..ApplicationController::MAX_RATING }
end
