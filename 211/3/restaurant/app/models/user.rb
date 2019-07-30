class User < ActiveRecord::Base
  validates_uniqueness_of :login, :email
  validates_presence_of :login, :email, :password_digest
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :reviews, dependent: :destroy
  has_secure_password
end
