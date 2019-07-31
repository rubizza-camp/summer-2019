class RestarauntController < ApplicationController
  get '/restaraunts/:id' do
    id = params[:id].to_i - 1
    @restaraunt = Restaraunt.all[id]
    @comments = @restaraunt.comments
    @rating = @comments.any? ? @comments.average(:rating).truncate(1) : 'Has no rating yet'
    erb :restaraunt
  end
end
