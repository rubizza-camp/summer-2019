class User < ActiveRecord::Base
  validates :password_digest, presence: true
  validates :username, :email, presence: true, uniqueness: true

  has_secure_password
  has_many :comments
end
