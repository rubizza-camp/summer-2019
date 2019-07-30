class User < ActiveRecord::Base
  include BCrypt

  validates_presence_of :login, :email, :password_hash
  validates :email, uniqueness: { case_sensitive: false, message: 'Email already in use' }
  validates :login, uniqueness: { case_sensitive: false, message: 'Login already exists' }
  has_many :reviews, dependent: :destroy

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def email_valid?
    Truemail.valid?(email)
  end
end
