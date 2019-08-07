class HomePageController < ApplicationController
  get '/' do
    redirect ('/places')
  end
end
