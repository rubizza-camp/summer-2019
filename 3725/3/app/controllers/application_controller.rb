class ApplicationController < Sinatra::Base

  set :views, File.expand_path('../../views', __FILE__)

  configure do
    set :views, 'app/views/'
    set :root, File.expand_path('../../../', __FILE__)
  end

  register Sinatra::Flash

end
