require './commands/registration'

module StartCommand
  include RegistrationCommand
  include Validation
  def start!
    if registered?
      respond_with :message, text: "Greetings #{session[:number]}"
    else
      respond_with :message, text: 'Hello! What is your number?'
      save_context :registration!
    end
  end
end
