class Place < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :latitude, :longitude
end
