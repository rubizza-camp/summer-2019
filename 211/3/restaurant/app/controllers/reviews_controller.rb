class ReviewsController < BaseController
  post '/reviews/create' do
    @user = User.find(session[:user_id])
    @review = @user.reviews.new(mark: params[:mark], description: params[:description], restaurant_id: params[:restaurant_id])
    flash[:error] = @review.errors.full_messages unless @review.save
    redirect "/restaurants/#{params[:restaurant_id]}"
  end

end
