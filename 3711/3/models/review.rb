class Review < ActiveRecord::Base
  belongs_to :place
  belongs_to :user
  validates_presence_of :rating
end
