# frozen_string_literal: true

module ViewHelper
  def show_message(text)
    flash[:info] = text
  end

  def user_logged?
    session[:user_id]
  end
end
