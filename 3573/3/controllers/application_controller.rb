class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))

  configure do
    enable :sessions
    set :session_secret, ENV['SECRET']
  end

  not_found do
    status 404
    'Something wrong! Try to type URL correctly.'
  end
end
