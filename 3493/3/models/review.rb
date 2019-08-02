class Review < ActiveRecord::Base
  attribute :title
  attribute :description
  attribute :rating
  belongs_to :user
  belongs_to :place
end
