# frozen_string_literal: true

class BaseController < Sinatra::Base
  include WillPaginate::Sinatra::Helpers

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  register Sinatra::Partial

  set views: proc { File.join(root, '../views/') }
  set :method_override, true
  set :partial_template_engine, :erb

  error 403 do
    '403 Access forbidden'
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def error_message(message)
    flash[:danger] = message
  end

  def info_message(message)
    flash[:info] = message
  end
end
