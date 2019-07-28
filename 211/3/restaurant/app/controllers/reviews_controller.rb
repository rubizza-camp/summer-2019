# require_relative 'base_controller'
class ReviewsController < BaseController
  post '/reviews/create' do
    @review = Review.new(mark: params[:mark], description: params[:description], user_id: params[:user_id], restaurant_id: params[:restaurant_id])
    flash[:error] = @review.errors.full_messages unless @review.save
    redirect "/restaurants/#{params[:restaurant_id]}"
  end

  get '/reviews' do
    @reviews = Review.all
    erb :'reviews/index', layout: :layout
  end
end
