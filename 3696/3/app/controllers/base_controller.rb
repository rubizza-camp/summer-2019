require_relative '../helpers/auth_helper'
require_relative '../helpers/info_helper'
require_relative '../helpers/review_creator'
require_relative '../helpers/place_helper'

class BaseController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  register Sinatra::Namespace

  helpers InfoHelper::Helpers
  helpers PlaceHelper::Helpers
  helpers AuthHelper::Helpers
  helpers ReviewCreator::Helpers
end
