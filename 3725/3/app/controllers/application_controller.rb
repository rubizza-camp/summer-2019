class ApplicationController < Sinatra::Base
  set :views, File.expand_path('../views', __dir__)

  Tilt.register Tilt::ERBTemplate, 'html.erb'

  configure do
    set :views, 'app/views/'
    # rubocop:disable Lint/AmbiguousBlockAssociation
    set :public_folder, Proc.new { File.join(root, 'public') }
    # rubocop:enable Lint/AmbiguousBlockAssociation
    set :root, File.expand_path('../..', __dir__)
    enable :sessions
    set :session_secret, 'secret'
  end

  get '/' do
    redirect 'posts/all'
  end

  register Sinatra::Flash
end
