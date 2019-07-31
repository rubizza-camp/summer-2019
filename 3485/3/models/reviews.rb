require 'sinatra'
require 'sinatra/activerecord'

class Reviews < ActiveRecord::Base
  belongs_to :users
  belongs_to :places
end
