class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :shop
  validates_presence_of :text, :grade
  validates_inclusion_of :grade, in: 1..ApplicationController::MAX_RATING
end
