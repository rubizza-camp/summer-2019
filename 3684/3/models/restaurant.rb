require 'sinatra'
require 'sinatra/activerecord'

class Restaurant < ActiveRecord::Base
  has_many :comments
end
