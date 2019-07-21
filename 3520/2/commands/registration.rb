require './commands/validation'

module RegistrationCommand
  include Validation
  def registration!(number)
    if check_number!(number)
      respond_with :message, text: "I don't know you, boy. So try again or go away."
      save_context :registration!
    else
      respond_with :message, text: 'Greetings, young fellow.'
      session[:number] = number
    end
  end
  # def registered?
  #   session[:number]
  # end
end
