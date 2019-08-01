class CommentsContoller < ApplicationController
  post '/place/:id' do
    @comment = Comment.new(
      title: params[:title],
      rating: params[:rating],
      user_id: current_user.id,
      place_id: params[:id]
    )
    @place = Place.find_by_id(params[:id])
    if @comment.valid?
      @comment.save
      @place.update(place_rating: @place.comments.average(:rating))
    else
      flash[:message] = 'Error! Fill all forms'
    end
    redirect to "/place/#{params[:id]}"
  end
end
