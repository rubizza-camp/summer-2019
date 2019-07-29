require 'rack-flash'
class MainController < Sinatra::Base
  set views: proc { File.join(root, '../views/') }
  set public_folder: proc { File.join(root, '../public/') }

  get '/main' do
    @places = Place.all
    erb :main
  end
  use Rack::Flash
end
