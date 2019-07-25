require 'bcrypt'

include BCrypt

class User < ActiveRecord::Base
  has_many :reviews

  validates_presence_of :email, uniqueness: true
  validates_presence_of :name, uniqueness: true
  validates_presence_of :password
end
