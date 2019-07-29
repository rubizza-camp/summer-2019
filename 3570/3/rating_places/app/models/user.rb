
class User < ActiveRecord::Base
  has_secure_password
  has_many :comments, dependent: :destroy

  def password
    @password ||= BCrypt::Password.new(password_digest)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_digest = password
  end
end
