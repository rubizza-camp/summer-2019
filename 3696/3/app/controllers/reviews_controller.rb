# frozen_string_literal: true

require 'sinatra/namespace'
require_relative 'base_controller'

class ReviewsController < BaseController
  namespace '/review' do
    post '/new' do
      @place = Place.find_by(name: session[:place])
      if user_logged?
        create_review
        info_message review_validation_info
      else
        warning_message 'You must be logged in!'
      end
      redirect "/#{@place.name}"
    end
  end
end
