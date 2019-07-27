# frozen_string_literal: true

module StartCommand
  include Telegram::Bot::UpdatesController::MessageContext

  def start!
    save_context :authenticate
    message = session[:id] ? 'Вы уже зарегестрировались' : 'Введите номер по лагерю'

    respond_with :message, text: message
  end

  def authenticate(participant_id)
    session[:participant_id] = participant_id

    if user_exists? && session[:id] != participant_id
      session[:id] = participant_id

      respond_with :message, text: 'Регистрация прошла успешно'
    else
      save_context :authenticate

      respond_with :message, text: error_message
    end
  end

  private

  def user_exists?
    CSV.read('./data.csv').flatten.include?(session[:participant_id])
  end

  def error_message
    session[:id] != session[:participant_id] ? 'Юзер не существует' : 'Юзер уже зарегестрирован'
  end
end
