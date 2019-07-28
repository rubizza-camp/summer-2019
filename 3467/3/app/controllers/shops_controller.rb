class ShopsController < ApplicationController
  get '/' do
    @shops = Shop.all
    erb :index
  end

  get '/shops/:id' do
    @shop = Shop.find(params[:id])
    @reviews = @shop.reviews.includes(:user).order('id DESC')
    @review = @shop.reviews.new
    erb :shops
  end
end
