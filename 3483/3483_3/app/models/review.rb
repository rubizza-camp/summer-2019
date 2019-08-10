class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  validates :text, :grade, presence: true
  validates :grade, inclusion: { in: 1..ApplicationController::MAX_RATING }
end
