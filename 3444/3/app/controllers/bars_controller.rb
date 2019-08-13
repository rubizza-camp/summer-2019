class BarsController < ApplicationController
  get '/new' do
    env['warden'].authenticate!
    erb :'bars/new'
  end

  post '/new' do
    params.delete 'submit'
    @bar = Bar.create(params)
    redirect '/'
  end

  get '/:id/show' do
    @bar = Bar.find(params[:id])
    @bar_rate = RateCalculator.call(params[:id])
    @reviews = Review.where(bar_id: params[:id])
    erb :'bars/show'
  end
end
