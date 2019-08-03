class ApplicationController < Sinatra::Base

  set :views, File.expand_path('../../views', __FILE__)

  configure do
    set :views, 'app/views/'
    set :public_folder, Proc.new { File.join(root, "public") }
    set :root, File.expand_path('../../../', __FILE__)
    enable :sessions
    set :session_secret, "secret"
  end

  register Sinatra::Flash

end
