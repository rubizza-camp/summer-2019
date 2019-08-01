class ReviewsController < BaseController
  post '/restaurants/:id/reviews' do
    user = User.find(session[:user_id])
    review = user.reviews.new(mark: params[:mark],
                              description: params[:description],
                              restaurant_id: params[:id])
    flash[:error] = review.errors.full_messages unless review.save
    redirect "/restaurants/#{params[:id]}"
  end
end
