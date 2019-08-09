require_relative 'application_controller'

class LocationsController < ApplicationController
  before do
    @current_user = User.find(session[:user_id])
  end

  get '/location/:id' do
    @location = Location.find(params[:id])
    @commentaries = @location.commentaries.order('id DESC')
    @users = User.all
    erb :location
  end

  post '/location/:id/post' do
    commentary = Commentary.new(
      points: params[:points],
      text: params[:review],
      user_id: @current_user.id,
      location_id: params[:id]
    )
    if commentary.save
    else
      flash[:message] = commentary.errors.messages.values.join
    end
    redirect "/location/#{params[:id]}"
  end
end
