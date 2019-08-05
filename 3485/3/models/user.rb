require 'sinatra'
require 'sinatra/activerecord'

class User < ActiveRecord::Base
  validates :email, uniqueness: { case_sensitive: false, message: 'Email уже зарегистрирован!' }
  validates_confirmation_of :password, message: 'Пароли не совпадают'
  has_many :comments
end
