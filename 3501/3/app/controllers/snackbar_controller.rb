# frozen_string_literal: true

require 'sinatra/cookies'
require 'sinatra/base'
require './app/lib/user'

class SnackBarController < Sinatra::Base
  helpers Sinatra::Cookies
  get('/snackbars/new') do
    session[:current_user] = User.find_user_by_token(cookies[:user_token_id])
    erb(:snackbars_new)
  end

  post('/snackbars/new') do
    session[:current_user] = User.find_user_by_token(cookies[:user_token_id])
    session[:current_user]&.create_new_snackbar(self)
    redirect('/')
  end

  get('/snackbars/:id') do
    session[:current_user] = User.find_user_by_token(cookies[:user_token_id])
    @current_snack_bar = SnackBar.find_by_id(params['id'].to_i)
    return erb(:snackbar) if @current_snack_bar

    redirect('/')
  end

  post('/snackbars/:id/new_comment') do
    session[:current_user] = User.find_user_by_token(cookies[:user_token_id])
    return redirect('/') unless session[:current_user]

    session[:current_user].create_new_comment(self)
    redirect("/snackbars/#{params[:id]}")
  end
end
