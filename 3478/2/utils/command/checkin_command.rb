require 'date'
require_relative 'user_input_handler.rb'

module CheckinCommand
  include UserInputHandler
  def checkin!(*)
    session[:check_type] = 'checkin'
    save_context :ask_for_photo
    respond_with :message, text: '📸 Отправте селфи'
  end
end
