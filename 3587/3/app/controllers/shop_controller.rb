class ShopsController < ApplicationController
  get '/' do
    @shop = Shop.all
    erb :index
  end

  get '/shops/:id' do
    @shop = Shop.find(params[:id])
    @shop.reviews = Review.where(shop_id: params[:id])
    stars unless @shop.reviews.empty?
    session[:shop_id] = @shop.id
    erb :shop
  end
end
