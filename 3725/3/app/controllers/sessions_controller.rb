require_relative 'application_controller'

class SessionsController < Sinatra::Base

  get '/auth/sign_in' do
    erb :sign_in
  end

  post '/auth/sign_in' do
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now[:alert] = "Email or password is invalid"
      render "new"
    end
  end



  post '/auth/log_out' do
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

end
