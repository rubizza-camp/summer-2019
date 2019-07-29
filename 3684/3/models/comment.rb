require 'sinatra'
require 'sinatra/activerecord'

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :restaurant
end
