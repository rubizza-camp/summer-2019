# frozen_string_literal: true

require_relative '../helpers/session_helper'

class ApplicationController < Sinatra::Base
  configure do
    set :views, 'app/views'
    enable :sessions
  end

  register Sinatra::ActiveRecordExtension
  helpers SessionHelper
  register Sinatra::Flash

end
