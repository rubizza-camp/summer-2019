require_relative '../helpers/session_helper'
class BaseController < Sinatra::Base
  set :views, 'app/views'

  helpers SessionHelper

  register Sinatra::Flash
end
