require './lib/validation'
require './lib/persuation'

module CheckoutCommand
  include Validation::RegistrationProcess
  include Validation::SelfieAttachment
  include Validation::Geolocation
  include Validation::CheckinAssistant
  include Persuation

  def checkout!(*)
    if register_is_not_required && checkin_is_not_required
      save_context :selfie_attachment
      respond_with :message, text: 'Send me your beautiful selfie.'
    elsif register_is_not_required && checkin_is_required
      respond_with :message, text: 'You must try /checkin at first.'
    else
      respond_with :message, text: 'Do not try to deceive me. Register with the help of /start!'
    end
  end
end
