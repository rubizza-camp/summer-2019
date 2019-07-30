class User < ActiveRecord::Base
  include BCrypt
  has_many :comments
  validates_uniqueness_of :username, :email
  validates_presence_of :username, :email, :password_hash

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end
end