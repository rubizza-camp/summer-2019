class PlaceController < ApplicationController
  get '/' do
    @places = Place.all
    erb :index
  end

  get '/place/:id' do
    @place = Place.find(params[:id])
    @review = Review.where(place_id: params[:id]).reverse
    @average_score = average_score if @review.count.positive?
    flash[:message] = I18n.t(:unregistered_user) unless session?
    erb :place
  end

  attr_reader :review

  private

  def average_score
    review.inject(0) do |score, review|
      score + review.grade
    end / review.count
  end
end
