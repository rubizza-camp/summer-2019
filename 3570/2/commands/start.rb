# frozen_string_literal: true

require 'yaml'
require_relative '../entities/cadet'
require_relative '../entities/cadet_registration'

module StartCommand
  def start!(*)
    if session.key?(:cadet_id)
      respond_with :message, text: 'Ты авторизирован, продолжай'
    else
      save_context :start_context
      respond_with :message, text: 'Введи свой номер, курсант'
    end
  end

  def start_context(cadet_number = nil, *)
    cadet = CadetRegistration.new(cadet_number, user_telegram_id).call
    if cadet.valid?
      session[:cadet_id] = user_telegram_id
      respond_with :message, text: 'Регистрация прошла успешно'
    else
      respond_with :message, text: cadet.error
    end
  end

  private

  def user_telegram_id
    payload['from']['id']
  end
end
