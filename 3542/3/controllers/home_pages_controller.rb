require_relative 'application_controller'

class HomePagesController < ApplicationController
  set :views, File.realpath('./views/static_pages')

  get '/' do
    haml :home
  end
end
