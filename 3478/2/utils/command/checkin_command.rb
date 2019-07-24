require 'date'
require_relative 'user_input_handler.rb'

module CheckinCommand
  include UserInputHandler
  def checkin!(*)
    session[:check_type] = 'checkin'
    respond_with :message, text: '📸 Отправтье селфи'
    ask_for_photo
  end
end
