class Restaurant < ActiveRecord::Base
  validates_uniqueness_of :name, :location, :description, :photo
  validates_presence_of :name, :location, :description, :photo

  has_many :reviews
end

