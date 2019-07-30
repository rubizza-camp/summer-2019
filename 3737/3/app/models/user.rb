class User < ActiveRecord::Base
  has_many :comments
  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email, :password_hash
end
