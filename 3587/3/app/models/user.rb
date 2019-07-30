class User < ActiveRecord::Base
  include BCrypt

  validates :name, presence: true
  validates_uniqueness_of :email
  validate :valid_email?

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end

  def valid_email?
    errors.add(:email, message: 'Неправильная почта') unless Truemail.valid?(email) && email?
  end
end
