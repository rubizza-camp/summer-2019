class ReviewsController < Sinatra::Base
  configure do
    set :views, proc { File.join(root, '../views/reviews') }
  end

  get '/reviews' do
    erb :index
  end

  post '/reviews/new' do
    puts params.inspect
    Review.create(user_id: session[:user].id, place_id: params['place_id'],
                  rating: params['rating'], text: params['note'])
    redirect "/places/#{params['place_id']}"
  end
end
