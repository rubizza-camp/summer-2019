class Place < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :location, :main_description, :full_description
end
