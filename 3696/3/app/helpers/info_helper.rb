require 'sinatra/base'

class InfoHelper < Sinatra::Base
  module Helpers
    def review_validation_info
      if @review.valid?
        @review.save
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

  helpers Helpers
end
