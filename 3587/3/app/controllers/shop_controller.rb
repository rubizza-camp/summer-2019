class ShopsController < ApplicationController
  get '/' do
    @shop = Shop.all
    erb :index
  end

  get '/shop/:id' do
    @shop = Shop.find(params[:id])
    @shop.reviews = Review.where(shop_id: params[:id])
    stars unless @shop.reviews.empty?
    erb :shop
  end
end
