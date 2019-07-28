require './config/environment'
require 'sinatra/activerecord'
require 'sinatra/base'
require 'sinatra/flash'

require_relative 'base_controller.rb'
require_relative 'users_controller.rb'
require_relative 'restaurants_controller.rb'
require_relative 'reviews_controller.rb'

class ApplicationController < Sinatra::Base
  configure do
    set views: proc { File.join(root, '../views/') }
    enable :sessions
  end

  register Sinatra::Flash

  get '/' do
    erb :index
  end

  use UsersController
  use RestaurantsController
  use ReviewsController
end

# Пользователь может зарегистрироваться на отдельной странице, введя свои имя, имейл и пароль.

# Пользователь может войти в систему, когда введет свой имейл и пароль на странице логина.

# Пользователь может разлогиниться (когда, например, он залогинился не на своем компьютере, а на компьютере друга).
