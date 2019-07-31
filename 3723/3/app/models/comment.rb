class Comment < ActiveRecord::Base
  validates :title, :rating, presence: true
  belongs_to :user
  belongs_to :place
end
