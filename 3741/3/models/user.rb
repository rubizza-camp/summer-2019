# User data base model
class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_hash
  validates_uniqueness_of :username, :email
  validate :mail_valid?
  has_many :reviews, dependent: :destroy

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end

  def password
    BCrypt::Password.new(password_hash)
  end

  def mail_valid?
    errors.add(:email, 'wrong mail') unless Truemail.valid?(email)
  end
end
