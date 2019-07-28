require 'sinatra/base'

module ReviewCreator
  def create_review
    @user = User.find(session[:user_id])
    @review = @user.reviews.create(grade: params[:grade].to_i, text: params[:text])
    @review.place_id = @place.id
  end
end
