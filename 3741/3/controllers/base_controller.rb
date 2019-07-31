# frozen_string_literal: true

require_relative '../helpers/view_helper'

class BaseController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash
  register Sinatra::Namespace
  helpers ViewHelper
end
