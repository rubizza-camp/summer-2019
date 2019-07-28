require 'sinatra/activerecord'
require 'sinatra/form_helpers'

class BaseController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  register Sinatra::Contrib

  helpers Sinatra::FormHelpers
end
