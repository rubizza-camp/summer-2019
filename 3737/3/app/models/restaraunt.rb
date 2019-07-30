class Restaraunt < ActiveRecord::Base
  has_many :comments
  validates_presence_of :name, :coordinate
end
