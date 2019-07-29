class Review < ActiveRecord::Base
  belongs_to :bar

  VALID_RATE_REGEX = /[1-5]/

  validates :comment, presence: true
  validates :rating,
            presence: true,
            numericality: { only_integer: true },
            format: { with: VALID_RATE_REGEX }
end
