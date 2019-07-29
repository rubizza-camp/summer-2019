class User < ActiveRecord::Base
  validates_presence_of :login, :email, :password_hash
  validates_uniqueness_of :login, :email
  has_many :reviews, dependent: :destroy

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end
end
