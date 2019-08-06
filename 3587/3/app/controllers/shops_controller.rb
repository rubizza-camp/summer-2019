class ShopsController < ApplicationController
  get '/' do
    @shop = Shop.all
    erb :index
  end

  get '/shops/:id' do
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.includes(:user).where(shop_id: params[:id])
    erb :shop
  end
end
