# frozen_string_literal: true

require 'sinatra/base'
require 'sinatra/cookies'
require 'sinatra/strong-params'
require './app/lib/user'

class SnackBarController < Sinatra::Base
  register Sinatra::StrongParams
  helpers Sinatra::Cookies

  get('/snackbars/new') do
    erb(:snackbars_new)
  end

  post('/snackbars/new', needs: %i[description name photo telephone working_time_opening
                                   working_time_closing latitude longitude]) do
    session[:current_user].snack_bars.create(params)
    redirect('/')
  end

  get('/snackbars/:id') do
    @current_snack_bar = SnackBar.find_by_id(params['id'].to_i)
    erb(:snackbar)
  end

  post('/snackbars/:id/new_comment') do
    session[:current_user].feed_backs.create(
      snack_bar_id: params[:id],
      content: params[:content],
      raiting: params[:raiting],
      date: Time.now
    )

    session[:current_user].update_snackbar_commnets_count_and_rait(self)
    redirect("/snackbars/#{params[:id]}")
  end
end
