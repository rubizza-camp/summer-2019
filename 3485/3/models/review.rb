require 'sinatra'
require 'sinatra/activerecord'

class Review < ActiveRecord::Base
  belongs_to :users
  belongs_to :place
end
