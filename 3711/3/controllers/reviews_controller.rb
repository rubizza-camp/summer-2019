class ReviewsController < Sinatra::Base
  configure do
    set :views, Proc.new { File.join(root, '../views/reviews') }
  end

  get '/reviews' do
    erb :index
  end
end
