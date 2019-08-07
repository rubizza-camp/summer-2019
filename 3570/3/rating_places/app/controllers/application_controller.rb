# frozen_string_literal: true

require_relative '../helpers/session_helper'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    set :root, '/places'
    enable :sessions
  end

  register Sinatra::ActiveRecordExtension
  helpers SessionHelper
  register Sinatra::Flash

  I18n.load_path << Dir[File.expand_path('config/locales') + '/*.yml']
  I18n.default_locale = :ru

  get '/' do
    redirect '/places'
  end
end
