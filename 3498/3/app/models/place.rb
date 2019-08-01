class Place < ActiveRecord::Base
  validates :name, presence: true
  has_many :comments
end
