class ApplicationController < Sinatra::Base
  configure do 
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  get '/' do
    @restaraunts = Restaraunt.all
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def logged_in
      !!current_user
    end

    def create_comment
      @user = User.find_by(id: session[:user_id])
      @comment = @user.comment.create(text: params[:text], stars: params[:stars].to_i)
      @comment.restaraunt_id = @restaraunt_id
    end

    def average_stars(restaraunt_id)
      Comment.where(restaraunt_id: restaraunt_id).avg(:stars)
    end
  end
end