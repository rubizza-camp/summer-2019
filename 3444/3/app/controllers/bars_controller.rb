class BarsController < ApplicationController
  show_new_bar = lambda do
    env['warden'].authenticate!
    erb :'bars/new'
  end

  create_new_bar = lambda do
    params.delete 'submit'
    @bar = Bar.create(params)
    redirect '/'
  end

  show_some_bar = lambda do
    @bar = Bar.find(params[:id])
    @bar_rate = calculate_rate(params[:id])
    @reviews = Review.where(bar_id: params[:id])
    erb :'bars/show'
  end

  get '/new', &show_new_bar
  post '/new', &create_new_bar
  get '/:id/show', &show_some_bar
end
