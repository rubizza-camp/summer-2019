require_relative 'application_controller'

class HomePagesController < ApplicationController
  get '/' do
    if login?
      redirect '/places'
    else
      redirect '/login'
    end
  end
end
