class ShopsController < ApplicationController
  get '/' do
    @shop = Shop.all
    erb :index
  end

  get '/shops/:id' do
    @shop = Shop.find(params[:id])
    @review = @shop.review.includes(:user)
    erb :shop
  end
end
