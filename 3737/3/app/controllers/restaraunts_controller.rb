class RestarauntsController < ApplicationController
  get '/restaraunt/:name' do
    @restaraunt = Restaraunt.find_by(name: params[:name])
    erb :restaraunt
  end

  post '/restaraunt/:name/new' do
    @restaraunt = Restaraunt.find_by(name: params[:name])
    if current_user
      create_comment
    else
      redirect '/login'
    end
    @restaraunt.update(average_star: average_stars(@restaraunt.id))
    puts @restaraunt.average_star
    redirect "/restaraunt/#{@restaraunt.name}"
  end
end
