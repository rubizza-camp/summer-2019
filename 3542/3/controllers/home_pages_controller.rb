require_relative 'application_controller'

class HomePagesController < ApplicationController
  before do
    return if request.path_info == '/login'
    return if request.path_info == '/signup'

    redirect '/login' unless login?
  end

  get '/' do
    haml '/places'
  end
end
