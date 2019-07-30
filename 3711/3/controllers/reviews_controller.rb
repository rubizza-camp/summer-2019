require_relative '../helpers/auth'
require_relative '../helpers/crypt'

class ReviewsController < Sinatra::Base
  include AuthHelper
  include CryptHelper

  register Sinatra::Flash

  configure do
    set :views, proc { File.join(root, '../views/reviews') }
  end

  # get '/reviews' do
  #   erb :index
  # end

  post '/reviews/new' do
    puts params.inspect
    Review.create(user_id: session[:user].id, place_id: params['place_id'],
                  rating: params['rating'], text: params['note'])
    info_message('Thanks for yor review!')
    redirect "/places/#{params['place_id']}"
  end
end
