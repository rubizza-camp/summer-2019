class Review < ActiveRecord::Base
  attribute :title
  attribute :text
  attribute :rating
  belong_to :user
  belong_to :restaurant
end
