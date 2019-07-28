module RestaurantHelper

  def average_cafe_mark
    array_of_marks = []
    Comment.where(place_id: session[:rest_id]).each { |comment| array_of_marks << comment.grade }
    @average_mark = array_of_marks.inject{ |sum, el| sum + el }.to_f / array_of_marks.size
  end

  def info_about_selected_cafe
    @rest = Restaurant.all.find_by(name: params[:name])
    session[:rest_id] = @rest.id
    average_cafe_mark
  end
  def good_mark?
    params[:rate].to_i > 2
  end
  def ask_about_comment
    return if comment?
    flash[:danger] = 'Add comment!!!!!!!!'
    redirect "/#{session[:cafe_name]}"
  end
  def comment?
    params[:text].length > 1
  end
end
