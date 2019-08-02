# :reek:InstanceVariableAssumption
class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, ENV['SESSION_SECRET']
    register Sinatra::Flash
  end

  get '/' do
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def add_comment
      @user ||= User.find_by(id: session[:user_id])
      @comment ||= @user.comments.new(text: params[:text], rating: params[:rating])
      if @comment.save
        @comment.restaurant_id = params[:id]
      else
        redirect "/restaraunts/#{@restaurant.id}"
      end
    end
  end
end
