# frozen_string_literal: true

require 'sinatra/namespace'
require_relative 'base_controller'

class ReviewsController < BaseController
  namespace '/reviews' do
    post '/:place_name/new' do
      @place = Place.find_by(name: params[:place_name])
      if user_logged?
        create_review
        info_message review_validation_info
      else
        warning_message 'You must be logged in!'
      end
      redirect "/places/#{@place.name}"
    end
  end
end
