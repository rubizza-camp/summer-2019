require 'bcrypt'
require 'truemail'

#:reek:InstanceVariableAssumption and :reek:UtilityFunction
class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
  end

  Truemail.configure do |config|
    config.verifier_email = 'hajiwidec@freetmail.net'
  end

  get '/' do
    @restaraunts = Restaraunt.all
    erb :index
  end

  helpers do
    def current_user
      @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
    end

    def create_comment
      @user = User.find_by(id: session[:user_id])
      @comment = @user.comments.create(text: params[:text], star: params[:star].to_i)
      @comment.restaraunt_id = @restaraunt.id
      valid_comment
    end

    def valid_comment
      if @comment.valid?
        @comment.save
      else
        redirect "/restaraunt/#{@restaraunt.name}"
      end
    end

    def average_stars(restaraunt_id)
      Comment.where(restaraunt_id: restaraunt_id).average(:star).round(2)
    end

    def password(new_password)
      BCrypt::Password.create(new_password)
    end
  end
end
