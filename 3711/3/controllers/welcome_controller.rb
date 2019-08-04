class WelcomeController < Sinatra::Base
  get '/' do
    redirect '/places/'
  end
end
