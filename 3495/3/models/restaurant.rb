class Restaurant < ActiveRecord::Base
  attribute :name
  attribute :short_description
  attribute :long_description
  attribute :image_path
  attribute :address
  attribute :rating
  has_many :review
end
