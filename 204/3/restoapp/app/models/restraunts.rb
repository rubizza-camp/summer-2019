class Restraunt < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :title, uniqueness: true
  validates_presence_of :description
  validates_presence_of :location
end
