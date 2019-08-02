class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, dependent: :destroy
  validates :username, :email, :password_digest, presence: true, uniqueness: true
end
