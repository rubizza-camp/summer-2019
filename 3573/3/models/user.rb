require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  include BCrypt

  has_many :comments

  validates :name, :email, :password_hash, presence: true
  validates_uniqueness_of :email
  validates_format_of :email, with: /@/

  def password
    Password.new(password_hash)
  end

  def password=(new_password)
    self.password_hash = Password.create(new_password)
  end
end
