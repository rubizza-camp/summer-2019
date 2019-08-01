class User < ActiveRecord::Base
  validates_uniqueness_of :email
  validates_presence_of :name, :email
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  has_many :reviews, dependent: :destroy
  has_secure_password
end
