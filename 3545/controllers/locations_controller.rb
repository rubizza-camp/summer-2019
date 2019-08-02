require_relative 'application_controller'

class LocationsController < ApplicationController

  get '/location/:id' do
    @current_user = User.find(session[:user_id])
    @location = Location.find(params[:id])
    erb :location
  end

end