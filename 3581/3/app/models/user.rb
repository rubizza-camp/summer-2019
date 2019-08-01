class User < ActiveRecord::Base
  has_many :reviews
  has_many :reviews
  validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :name, :email

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    password = Password.create(new_password)
    self.password_hash = password
  end
end
