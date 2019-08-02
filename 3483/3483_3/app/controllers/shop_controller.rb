class ShopController < ApplicationController
  attr_reader :reviews
  get '/' do
    @shops = Shop.all
    erb :index
  end

  get '/shop/:id' do
    @shops = Shop.find(params[:id])
    @reviews = Review.where(place_id: params[:id])
    stars if @reviews.count.positive?
    erb :shop
  end

  def stars
    @stars = reviews.pluck(:grade).inject(&:+) / reviews.count
  end
end
