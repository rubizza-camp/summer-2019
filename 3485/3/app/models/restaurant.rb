class Restaurant < ActiveRecord::Base
  belongs_to :raiting
  has_many :comments
end
