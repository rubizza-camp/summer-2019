require_relative './config/environment.rb'

Sinatra::Base.register Sinatra::Session
Sinatra::Base.register Sinatra::ActiveRecordExtension
Sinatra::Base.set :session_fail, '/sign_in'
Dotenv.load
Sinatra::Base.set :session_secret, ENV['SESSION_SECRET']

require 'i18n'
I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en

use UserController
use PlaceController
run(MainController)
