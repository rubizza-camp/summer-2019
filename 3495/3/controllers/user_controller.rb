require 'pagy/extras/bootstrap'
class UserController < ApplicationController
  include Pagy::Backend
  include Pagy::Frontend
  Dotenv.load
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    @pagy, @places = pagy(Place.all, items: 8)
    erb :base
  end

  post '/user_login', needs: %i[email pass] do
    user = User.find_by(email: params['email'])
    if user && BCrypt::Password.new(user[:password]) == params['pass']
      session[:name] = user[:name].to_s
      session[:id] = user[:id]
      session.delete(:error)
    else
      session[:error] = 'Wrong email or password'
    end
    redirect @env['HTTP_REFERER']
  end

  post '/user_logout' do
    session.delete(:name) && session.delete(:id)
    redirect @env['HTTP_REFERER']
  end

  post '/user_registration', needs: %i[name email] do
    User.create(name: params['name'], email: params['email'],
                password: BCrypt::Password.create(params['pass']).to_s)
    session[:name] = params['name']
    session[:id] = User.last[:id]
    redirect @env['HTTP_REFERER']
  end

  get '/place_registration' do
    erb :place_registration
  end

  get '/place_registrate', needs: %i[nam short_desc long_desc image_link addr] do
    Place.create(name: params['nam'], short_description: params['short_desc'],
                 long_description: params['long_desc'], image_path: params['image_link'],
                 address: params['addr'])
    erb :base
  end

  get '/place/:id', needs: %i[id] do
    @place = Place.find(params['id'])
    erb :show_place
  end

  post '/place/:id', needs: %i[id title text rating] do
    @place = Place.find(params['id'])
    Review.create(title: params[:title], text: params[:text], rating: params[:rating],
                  place_id: params[:id], user_id: session[:id])
    @place.update(rating: Review.where(place_id: params[:id]).average(:rating).round(1))
    redirect "/place/#{params['id']}"
  end
end
