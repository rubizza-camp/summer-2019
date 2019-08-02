class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :place
  validates :comment, presence: true, length: { minimum: 1 }
  validates :rating, presence: true
end
