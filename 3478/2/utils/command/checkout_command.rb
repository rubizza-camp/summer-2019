require 'date'
require_relative 'check.rb'

module CheckoutCommand
  include Check
  def checkout!(*)
    session[:check_type] = 'checkout'
    save_context :ask_for_photo_check
    respond_with :message, text: '📸 Отправтье селфи'
  end
end
