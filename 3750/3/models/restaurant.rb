class Restaurant < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  validates_presence_of :name, :latitude, :longitude
end
