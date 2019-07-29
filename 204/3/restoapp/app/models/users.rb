require 'bcrypt'

class User < ActiveRecord::Base
  include BCrypt

  has_many :reviews

  validates_presence_of :email, uniqueness: true
  validates_presence_of :name, uniqueness: true
  validates_presence_of :password
end
