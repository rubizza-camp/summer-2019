class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  helpers Sinatra::Cookies
  register Sinatra::StrongParams
  include Pagy::Backend
  include Pagy::Frontend
  include CookiesHelper
  include ReviewHelper
end
