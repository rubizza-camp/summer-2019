class MainController < Sinatra::Base
  get '/' do
    redirect '/places'
  end
end
