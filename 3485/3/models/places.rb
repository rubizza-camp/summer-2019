require 'sinatra'
require 'sinatra/activerecord'

class Places < ActiveRecord::Base
  has_many :reviews
end
