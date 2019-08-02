# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'
require 'sinatra/strong-params'
require './app/lib/user'

class SnackBarController < Sinatra::Base
  register Sinatra::StrongParams
  helpers Sinatra::Cookies

  get('/snackbars/new') do
    @current_user = User.find_by_id(session[:user_id])
    erb(:snackbars_new)
  end

  post('/snackbars/new', needs: %i[description name photo telephone working_time_opening
                                   working_time_closing latitude longitude]) do
    puts 'creating'
    User.find_by_id(session[:user_id]).snack_bars.create(params)
    redirect('/')
  end

  get('/snackbars/:id') do
    @current_user = User.find_by_id(session[:user_id])
    return redirect('/') unless (@current_snack_bar = SnackBar.find_by_id(params['id']))

    @snack_bar_feed_backs = @current_snack_bar.feed_backs
    erb(:snackbar)
  end

  post('/snackbars/:id/new_comment', needs: %i[id content rating]) do
    User.find_by_id(session[:user_id]).feed_backs.create(
      snack_bar_id: params[:id],
      content: params[:content],
      rating: params[:rating],
      date: Time.now
    )
    User.find_by_id(session[:user_id]).update_snackbar_commnets_count_and_rait(self)
    redirect("/snackbars/#{params[:id]}")
  end
end
