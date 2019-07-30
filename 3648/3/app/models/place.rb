class Place < ActiveRecord::Base
  has_many :comments
  validates_presence_of :place_name, :location
end
