require_relative 'application_controller'

class HomePagesController < ApplicationController
  get '/' do
    haml '/places'
  end
end
