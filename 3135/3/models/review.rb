class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant

  validates :rating, inclusion: { in: 0..5 }
  validates :description, presence: { message: 'low rating' }, if: Proc.new { |a| a.rating < 4}
end
