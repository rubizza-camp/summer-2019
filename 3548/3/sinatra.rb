require 'sinatra'

get '/' do
  'Hello world!'
end

get '/:name' do
  name = params['name']
  "Hello #{name}!"
end
