require 'uri'
class User < ActiveRecord::Base
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Email isn't correct" }
  validates :email, uniqueness: { case_sensitive: false, message: 'This email already taken' }
  validates :name, presence: { message: "Name can't be empty" }
  validates :name, uniqueness: { case_sensitive: false, message: 'This name already taken' }
  validates :password, presence: { message: "Password can't be empty" }
  has_many :comments
end
