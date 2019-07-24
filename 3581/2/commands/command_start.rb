require './verification.rb'

module CommandStart
  include Verification
  include Verification::RegistrationProcess

  def start!(*)
    if register_is_not_required
      respond_with :message, text: t(:already_registred)

    else
      save_context :number_input
      respond_with :message, text: t(:not_registred)
    end
  end

  def number_input(number)
    if NumbersHandler.new(number, self).valid_number
      chat_session[session_key] ||= {}
      chat_session[session_key]['number'] ||= number
      respond_with :message, text: t(:success_registered)
    else
      save_context :number_input
      respond_with :message, text: t(:wrong_number)
    end
  end
end
