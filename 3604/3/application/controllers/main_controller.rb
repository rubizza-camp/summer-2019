class MainController < Sinatra::Base
  get '/' do
    redirect '/places'
  end

  get %r{/.*/?} do
    redirect '/'
  end
end
