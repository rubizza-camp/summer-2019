class UserController < Sinatra::Base
  set :views, File.expand_path(File.join(__FILE__, '../../views'))
  get '/' do
    binding.pry
    @users = User.all
    erb :index
  end
end