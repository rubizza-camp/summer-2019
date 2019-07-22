require './validations/validations'

module Start
  include Validations
  include Validations::Registration

  def start!(*)
    if registered?
      respond_with :message, text: t(:already_registered)
    else
      save_context :number_set
      respond_with :message, text: t(:give_number)
    end
  end

  def number_set(number)
    if Student.new(number, self).valid_number?
      chat_session[session_key] ||= {}
      chat_session[session_key]['number'] ||= number
      respond_with :message, text: t(:succesfull_registration)
    else
      save_context :number_set
      respond_with :message, text: t(:wrong_number)
    end
  end
end
