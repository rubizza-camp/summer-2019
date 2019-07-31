require 'sinatra'
require 'sinatra/base'
require 'sinatra/activerecord'
require 'sinatra/flash'
require 'pry'

['posts_controller', 'users_controller'].each {|file| require_relative file }

class ApplicationController < Sinatra::Base

  register Sinatra::Flash

  use ::PostsController
  use ::UsersController

end
