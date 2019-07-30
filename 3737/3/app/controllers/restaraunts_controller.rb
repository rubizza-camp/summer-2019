class RestarauntsController < ApplicationController
  get '/restaraunt/:name' do
    @restaraunt = Restaraunt.find_by(name: params[:name])
    #@comment = Comment.where(restaraunt_id: params[:id])
    erb :restaraunt
  end
end
