require_relative 'application_controller'

class HomePagesController < ApplicationController
  set :views, File.realpath('./views/static_pages')

  before do
    return if request.path_info == '/login'
    return if request.path_info == '/signup'

    redirect '/login' unless login?
  end

  get '/' do
    haml '/places'
  end
end
