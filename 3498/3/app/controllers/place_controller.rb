class PlaceController < Sinatra::Base
  include PlaceHelper

  set :views, 'app/views'

  get '/place/:place_name' do
    load_place_info
    erb :about_place
  end

  post '/rate' do
    rate_place
    redirect '/'
  end
end
