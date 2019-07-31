require_relative './config/environment.rb'

Sinatra::Base.register Sinatra::Session
Sinatra::Base.register Sinatra::ActiveRecordExtension
Sinatra::Base.set :session_fail, '/sign_in'
Dotenv.load
Sinatra::Base.set :session_secret, ENV['SESSION_SECRET']

Sinatra::Base.set views: proc { File.join(root, '../views/') }
Sinatra::Base.set public_folder: proc { File.join(root, '../public/') }

I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
I18n.default_locale = :en

Truemail.configure do |config|
  config.verifier_email = 'verifier@example.com'
end

use UserController
use PlacesController
run(MainController)
