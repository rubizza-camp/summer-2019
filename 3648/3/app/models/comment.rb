class Comment < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  validates :title, :rating, presence: true
end
