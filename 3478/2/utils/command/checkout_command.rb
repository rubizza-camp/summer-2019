require 'date'
require_relative 'user_input_handler.rb'

module CheckoutCommand
  include UserInputHandler
  def checkout!(*)
    session[:check_type] = 'checkout'
    save_context :ask_for_photo
    respond_with :message, text: '📸 Отправте селфи'
  end
end
