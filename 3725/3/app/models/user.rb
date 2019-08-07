class User < ActiveRecord::Base
  has_many :reviews
  validates :password, presence: true
  validates :email, presence: true

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end
end
