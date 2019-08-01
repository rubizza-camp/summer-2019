class PlaceController < Sinatra::Base
  include PlaceHelper

  set :views, 'app/views'

  configure do
    enable :sessions
  end

  get '/:name' do
    load_place_info
    erb :about_place
  end

  post '/rate' do
    rate_place
    redirect "/#{session[:place_name]}"
  end
end
