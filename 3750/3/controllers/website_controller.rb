require_relative 'base_controller'

class WebsiteController < BaseController
  RESTAURANTS_PER_PAGE = 10

  get '/' do
    @restaurants = Restaurant.all.paginate(page: params[:page], per_page: RESTAURANTS_PER_PAGE)
    erb :home
  end
end
