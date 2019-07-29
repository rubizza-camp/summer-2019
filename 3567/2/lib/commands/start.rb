require './lib/validation'

module StartCommand
  include Validation
  include Validation::RegistrationProcess

  def start!(*)
    if register_is_not_required
      respond_with :message, text: 'You have already been registered.'

    else
      save_context :camp_number_input
      respond_with :message, text: 'Hi, send me your camp number, please.'
    end
  end

  def camp_number_input(camp_number)
    if CampNumbers.new(camp_number, self).valid_camp_number
      chat_session[session_key] ||= {}
      chat_session[session_key]['camp_number'] ||= camp_number
      respond_with :message, text: 'My congratulations! You are finally registered.'
    else
      save_context :camp_number_input
      respond_with :message, text: 'Do not try to deceive me. Enter your number correctly!'
    end
  end
end
