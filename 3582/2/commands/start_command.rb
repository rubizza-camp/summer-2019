require 'yaml'
require './modules/registration'
module StartCommand
  include Registration

  def start!(*)
    if session[:telegram_id] == session_key
      say_hello
    else
      save_context :check_registration
      respond_with :message, text: 'Напиши свой номер по лагерю'
    end
  end

  def say_hello
    if session[:checkined]
      respond_with :message, text: 'Твоя смена открыта(закрыть смену /checkout)'
    else
      respond_with :message, text: 'Ты можешь начать смену(/checkin)'
    end
  end
end
