class Bar < ActiveRecord::Base
  has_many :reviews, dependent: :destroy
  self.per_page = 10
end
