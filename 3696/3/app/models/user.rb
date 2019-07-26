class User < ActiveRecord::Base
  validates_presence_of :username, :email, :password_hash
  validates_uniqueness_of :username, :email
  has_many :reviews, dependent: :destroy

  def password
    @password ||= BCrypt::Password.new(password_hash)
  end

  def password=(new_password)
    @password = BCrypt::Password.create(new_password)
    self.password_hash = password
  end
end
