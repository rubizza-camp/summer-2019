class User < ActiveRecord::Base
  validates :name, presence: true
  validates :email, presence: true
  validates_uniqueness_of :email
  has_secure_password
  has_many :reviews
end
