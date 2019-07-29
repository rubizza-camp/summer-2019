require 'rack-flash'

class ApplicationController < Sinatra::Base
  register Sinatra::Session
  register Sinatra::ActiveRecordExtension

  use Rack::Flash
  configure do
    set :session_fail, '/sign_up'
    set views: proc { File.join(root, '../views/') }
  end

  Truemail.configure do |config|
    config.verifier_email = 'verifier@example.com'
  end

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
end
