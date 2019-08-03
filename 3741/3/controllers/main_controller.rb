# frozen_string_literal: true

require_relative '../helpers/review_helper'
require_relative '../helpers/user_helper'
require_relative '../helpers/view_helper'
# main class
class MainController < Sinatra::Base
  configure do
    enable :sessions
    set :session_secret, ENV['SECRET']
    set views: proc { File.join(root, '../views/') }
    register Sinatra::ActiveRecordExtension
    register Sinatra::Flash
    register Sinatra::Namespace
    helpers ReviewHelper
    helpers UserHelper
    helpers ViewHelper
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  get '/' do
    @places = Place.all
    erb :home
  end

  def actual_user
    @actual_user ||= User.find_by(id: session[:user_id])
  end
end
