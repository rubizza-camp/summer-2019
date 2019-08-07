# frozen_string_literal: true

class AppController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  configure do
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
    enable :sessions
    set :public_folder, File.dirname(__FILE__) + '/public'
    set :session_secret, ENV['key']
  end

  def current_user
    @current_user ||= User.find(session[:user_id])
  end

  get '/' do
    erb layout: :layout
  end

    def add_new_comment
    current_user.comments.create(grade: params[:grade].to_i, text: params[:text], restaurant_id: @restaurant.id)
  end
end
