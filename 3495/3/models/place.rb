class Place < ActiveRecord::Base
  attribute :name
  attribute :short_description
  attribute :long_description
  attribute :image_path
  attribute :address
  attribute :rating
  has_many :reviews, dependent: :delete_all
end
