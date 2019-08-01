class User < ActiveRecord::Base
  validates :email, :password, presence: true
  validates :email, uniqueness: true

  has_secure_password

  has_many :comments
end
