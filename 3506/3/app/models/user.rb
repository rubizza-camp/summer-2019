#:reek:InstanceVariableAssumption
class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_hash
  validates_uniqueness_of :username, :email
  validate :email_valid?

  has_many :reviews

  def password
    BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end

  private

  def email_valid?
    errors.add(:name, 'Need a valid e-mail') unless Truemail.valid?(email)
  end
end
