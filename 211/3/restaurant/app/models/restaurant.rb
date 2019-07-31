class Restaurant < ActiveRecord::Base
  validates_presence_of :name, :location

  has_many :reviews, dependent: :destroy
end
