class WebhooksController < Telegram::Bot::UpdatesController
  include Telegram::Bot::UpdatesController::MessageContext
  include Telegram::Bot::UpdatesController::Session

  MESSAGES = {
    greeting: 'Hi! Enter your personal number',
    registered: 'Welcome back',
    register: 'Enter your personal number',
    successfully_registered: 'You are successfully registered',
    invalid_number: 'Person number is invalid',
    already_checked_out: 'You have already checked out',
    already_checked_in: 'You have already checked in',
    send_photo: 'Send me a photo',
    send_location: 'Send me geolocation',
    checked_in: 'You have successfully checked in',
    checked_out: 'You have successfully checked out'
  }.freeze

  self.session_store = :redis_store, { expires_in: 1.month }

  def message(*)
    reply_with :message, text: 'What do you mean?'
  end

  def start!(*)
    respond_with_message(:greeting)
    save_context :register
  end

  def register(person_number = nil, *)
    return respond_with_message(:registered) if user_registered?(person_number)

    ::Commands::Register.perform(payload,
      &respond_with_text_and_save_context(:register))
  end

  def checkin!(*)
    return respond_with_message(:already_checked_in) if current_user.checked_in?

    ::Commands::CheckIn.perform(payload,
      &respond_with_text_and_save_context(:checkin!))
  end

  def checkout!(*)
    return respond_with_message(:already_checked_out)
      if current_user.checked_out?

    ::Commands::CheckOut.perform(payload,
      &respond_with_text_and_save_context(:checkout!))
  end

  private

  def respond_with_text_and_save_context(context)
    lambda do |response, save_context|
      respond_with_message(response)
      save_context context if save_context
    end
  end

  def respond_with_message(message)
    respond_with :message, text: MESSAGES[message]
  end

  def user_registered?(person_number)
    User.person_number_exists?(person_number)
  end

  def current_user
    @current_user ||= User.find(telegram_id: chat['id']).first
  end
end
