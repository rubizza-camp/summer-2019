# :reek:IrresponsibleModule:
class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates_presence_of :username, :email
  validates_uniqueness_of :username, :email

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i }
end
