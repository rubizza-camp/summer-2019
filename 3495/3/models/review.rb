class Review < ActiveRecord::Base
  attribute :title
  attribute :text
  attribute :rating
  belongs_to :user
  belongs_to :place
end
