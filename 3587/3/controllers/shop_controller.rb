class ShopController < ApplicationController
  attr_reader :reviews
  get '/' do
    @shops = Shop.all
    erb :index, layout: :layout
  end

  get '/shop/:id' do
    @shops = Shop.find(params[:id])
    @reviews = Review.where(place_id: params[:id])
    @stars = stars if @reviews.count.positive?
    erb :shop
  end

  def stars
    reviews.inject(0) do |sum, review|
      sum + review.grade
    end / reviews.count
  end
end
