class RestarauntsController < ApplicationController
  get '/restaraunts/:name' do
    @restaraunt = Restaraunt.find_by(name: params[:name])
    erb :restaraunt
  end

  post '/restaraunts/:name/new' do
    @restaraunt = Restaraunt.find_by(name: params[:name])
    if current_user
      create_comment
    else
      redirect '/login'
    end
    @restaraunt.update(average_star: average_stars(@restaraunt.id))
    redirect "/restaraunts/#{@restaraunt.name}"
  end
end
