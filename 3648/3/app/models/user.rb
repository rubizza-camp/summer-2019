class User < ActiveRecord::Base
  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email, :password_hash
  has_secure_password
  has_many :comments, dependent: :destroy
end
