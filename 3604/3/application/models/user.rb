class User < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :email
  validate :email_must_be_valid

  def email_must_be_valid
    errors.add(:email) unless email? && Truemail.valid?(email)
  end

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end
end
