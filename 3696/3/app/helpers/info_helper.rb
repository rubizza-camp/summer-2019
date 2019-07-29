require 'sinatra/base'

module InfoHelper
  def review_validation_info
    if @review.save
      'Review created!'
    else
      'You need to enter more text before publishing!'
    end
  end

  def info_message(text)
    flash[:info] = text
  end

  def warning_message(text)
    flash[:danger] = text
  end
end
