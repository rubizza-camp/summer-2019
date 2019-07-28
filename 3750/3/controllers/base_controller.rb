require 'pry'
class BaseController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  def error_message(message)
    flash[:danger] = message
  end

  def info_message(message)
    flash[:info] = message
  end
end