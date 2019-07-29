class PlaceController < ApplicationController

  get '/places/:id' do
    erb :'places/show'
  end
end
