# frozen_string_literal: true

require 'sinatra/base'

module ViewHelper
  def show_message(text)
    flash[:info] = text
  end

  def user_logged?
    session[:user_id]
  end
end
