module RatingHelper
  BAD_RATING = 3

  def validate_review
    return need_for_comment if bad_review_without_comment
  end

  def bad_review_without_comment
    params['rating'].to_i <= BAD_RATING && params['note'].empty?
  end

  def need_for_comment
    retry_action 'Add comment to bad review.', "/places/#{params['place_id']}"
  end

  def retry_action(text, redirect_path)
    session[:error] = text
    redirect redirect_path
  end
end
