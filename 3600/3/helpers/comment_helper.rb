# frozen_string_literal: true
# rubocop:disable Metrics/LineLength

module CommentsHelper
  def add_new_comment
    @current_user.comments.create(grade: params[:grade].to_i, text: params[:text], restaurant_id: @restaurant.id)
    @comment.restaurant_id = @restaurant.id
    @comment.save
  end
end
# rubocop:disable Metrics/LineLength
