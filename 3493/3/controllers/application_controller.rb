require 'bcrypt'
class ApplicationController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  helpers Sinatra::Cookies
  include CookiesHelper
end
