require 'date'
require_relative 'check.rb'

module CheckinCommand
  include Check
  def checkin!(*)
    session[:check_type] = 'checkin'
    save_context :ask_for_photo_check
    respond_with :message, text: '📸 Отправтье селфи'
  end
end
