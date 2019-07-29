class User < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :username, :email, :password
  validates_uniqueness_of :username, :email

  validates :email, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
    message: "email regex" }
end
