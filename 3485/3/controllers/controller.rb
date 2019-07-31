require_relative 'application_controller'
require_relative 'placename'
require 'bcrypt'

class Controller < ApplicationController
  # include PlaceName

  post '/registration' do
    password = BCrypt::Password.create(params['password'])
    hash = { name: params['name'], email: params['email'], password: password }
    Users.create(hash)
    session[:users_id] = Users.last.id
    redirect '/home'
  end

  post '/login' do
    @users = Users.find_by(email: params['email'])
    if @users
      if BCrypt::Password.new(@users[:password]) == params['password']
        session[:users_id] = @users.id
        redirect '/home'
        session[:users_id] = true
      else
        redirect '/home'
      end
      session[:users_id] = true
    else
      redirect '/home'
    end
  end

  get '/logout' do
    session[:users_id] = false
    redirect '/home'
  end

  get '/home' do
    erb :home
  end

  get '/registration' do
    erb :registration
  end

  get '/places' do
    @places = Places.all
    erb :places
  end

  post '/leave_comment' do
    hash = {
      text: params['text'],
      score: params['score'],
      users_id: session[:users_id],
      restaurant_id: session['rest_id']
    }
    Reviews.create(hash)
    redirect "/#{@env['HTTP_REFERER'].slice(22..@env['HTTP_REFERER'].length)}"
  end
  # require 'pry'
  get '/place/:id' do
    # update_score(params[:id])
    @place = Places.find(params[:id])
    @reviews = Reviews.all
    erb :placepage
  end

  #   def update_score(id)
  #   #    binding.pry
  #     Places.find(id).update(score: count_score(Places.find(id).reviews))
  #   end
  #
  # def count_score(reviews)
  #   amount = 0.0
  #   reviews.each { |com| amount += com.score }
  #   amount / reviews.size
  # end
end
