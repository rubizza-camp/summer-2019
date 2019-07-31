require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false, message: 'Email уже зарегистрирован' }
  has_many :comments
end
