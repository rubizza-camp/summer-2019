class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false, message: 'Email already registered!' }
  validates_confirmation_of :password, message: 'Passwords do not match'
  has_many :comments
end
