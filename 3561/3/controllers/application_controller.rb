class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  configure do
    enable :sessions
    set :session_secret, ENV['SECRET']
  end

  private

  def redirect_back
    redirect env['HTTP_REFERER']
  end
end
