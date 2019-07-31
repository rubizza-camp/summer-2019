class Place < ActiveRecord::Base
  validates :name, presence: true
end
