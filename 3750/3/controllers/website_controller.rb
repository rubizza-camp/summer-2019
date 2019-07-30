require_relative 'base_controller'

class WebsiteController < BaseController
  get '/' do
    @restaurants ||= Restaurant.all
    erb :home
  end
end
