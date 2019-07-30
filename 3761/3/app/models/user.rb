class User < ActiveRecord::Base
  has_many :reviews
  validates_presence_of :name, :email, :password_hash
  validates_uniqueness_of :name, :email
  validate :email_can_be_valid

  include BCrypt

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def email_can_be_valid
    errors.add(:email, I18n.t(:invalid_email)) unless email? && Truemail.valid?(email)
  end
end
