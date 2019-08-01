class Review < ActiveRecord::Base
  belongs_to :place, counter_cache: true
  belongs_to :user
  validates :text, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
