class User < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :email

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end
end
