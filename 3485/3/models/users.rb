require 'sinatra'
require 'sinatra/activerecord'

class Users < ActiveRecord::Base
  validates :email, uniqueness: true
  has_many :reviews
end
