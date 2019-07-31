class Place < ActiveRecord::Base
  validates :name, :location, :description, :rating, presence: true

  has_many :comments
end
