class Review < ActiveRecord::Base
  belongs_to :places
  belongs_to :users
  validates_presence_of :rating
end
