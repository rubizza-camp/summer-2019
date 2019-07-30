class MainController < Sinatra::Base
  get '/main' do
    @places = Place.all
    erb :main
  end
end
