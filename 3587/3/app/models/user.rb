require 'bcrypt'
class User < ActiveRecord::Base
  include BCrypt

  validates :name, presence: true
  validates_uniqueness_of :email

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
