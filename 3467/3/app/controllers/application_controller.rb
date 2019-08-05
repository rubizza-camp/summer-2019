require './config/environment'
require 'i18n'
require 'i18n/backend/fallbacks'

class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions

    ActiveRecord::Base.logger = Logger.new(STDOUT)

    I18n.load_path += Dir[File.join('config', 'locales', '**', '*.yml')]
    I18n.locale = :ru
    I18n.backend.load_translations
  end
end
