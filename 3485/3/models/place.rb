require 'sinatra'
require 'sinatra/activerecord'

class Place < ActiveRecord::Base
  has_many :review
end
