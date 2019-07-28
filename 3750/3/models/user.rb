class User < ActiveRecord::Base
  include BCrypt

  validates_presence_of :login, :email, :password
  validates_uniqueness_of :login, :email
  has_many :reviews, dependent: :destroy

  # def saved_password
  #   @saved_password ||= BCrypt::Password.new(password)
  # end

  # def password=(new_password)
  #   @password = BCrypt::Password.create(new_password)
  #   self.password_hash = password
  # end
end