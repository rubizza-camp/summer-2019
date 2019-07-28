class Place < ActiveRecord::Base
  attribute :name
  attribute :description
  attribute :image_path
  has_many :reviews
end
