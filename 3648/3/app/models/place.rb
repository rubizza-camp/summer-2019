class Place < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  validates_presence_of :place_name, :location
end
