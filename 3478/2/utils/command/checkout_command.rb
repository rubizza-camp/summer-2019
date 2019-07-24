require 'date'
require_relative 'user_input_handler.rb'

module CheckoutCommand
  include UserInputHandler
  def checkout!(*)
    session[:check_type] = 'checkout'
    save_context :ask_for_photo_check
    respond_with :message, text: '📸 Отправтье селфи'
  end
end
