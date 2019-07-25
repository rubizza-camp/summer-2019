class Review < ActiveRecord::Base
  belongs_to :restraunts
  belongs_to :users
end
