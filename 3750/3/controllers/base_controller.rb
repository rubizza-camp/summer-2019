# frozen_string_literal: true

require 'pry'

class BaseController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  set :method_override, true

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  def username
    User.find_by(id: session[:user_id]).login
  end

  def error_message(message)
    flash[:danger] = message
  end

  def info_message(message)
    flash[:info] = message
  end
end
