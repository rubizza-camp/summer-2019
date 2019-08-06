class PlacesController < Sinatra::Base
  get '/' do
    @places = Place.all
    erb :home
  end

  get '/place/:place_name' do
    load_place_info
    erb :about_place
  end

  post '/rate' do
    rate_place
    redirect '/'
  end
end
