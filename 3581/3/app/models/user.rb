require 'uri'
class User < ActiveRecord::Base
  has_many :reviews
  validates :name, :email, :password_hash, presence: true
  validates :name,  :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: I18n.t(:invalid_email) }

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
