class Comment < ActiveRecord::Base
  belongs_to :place
  belongs_to :user

  validates :comment_text
  validates_presence_of :rating
end
