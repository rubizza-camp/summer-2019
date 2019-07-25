# frozen_string_literal: true

require_relative '../helpers/info_helper'
require_relative '../helpers/create_helper'
require_relative '../helpers/auth_helper'

class ReviewController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  helpers Sinatra::InfoHelper
  helpers Sinatra::CreateHelper
  helpers Sinatra::AuthHelper

  post '/review/new' do
    @place = Place.find_by(name: session[:place])
    if user_logged?
      create_review
      info_message review_validation_info
    else
      warning_message 'You must be logged in!'
    end
    redirect "/#{@place.name}"
  end
end
