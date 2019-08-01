# frozen_string_literal: true

require 'sinatra/namespace'
require_relative 'main_controller'
# :reek:InstanceVariableAssumption
class ReviewsController < MainController
  namespace '/reviews' do
    helpers do
      def create_review
        @user = User.find(session[:user_id])
        @review = Review.create(stars: params[:stars].to_i,
                                comment: params[:comment],
                                place_id: @place.id,
                                user_id: @user.id)
      end

      def review_validation
        if @review.persisted?
        else
          'need more text'
        end
      end
    end

    post '/:place_id/new' do
      @place = Place.find(params[:place_id])
      if user_logged?
        create_review
        show_message review_validation
      else
        show_message 'not login in'
      end
      redirect "/places/#{@place.id}"
    end
  end
end
