require './verification.rb'
require './confirmation.rb'

module CommandCheckout
  include Verification::RegistrationProcess
  include Verification::SelfieAttachment
  include Verification::Geolocation
  include Verification::CheckinAssistant
  include Confirmation

  def checkout!(*)
    if register_is_not_required && checkin_is_not_required
      save_context :selfie_attachment
      respond_with :message, text: t(:selfie)
    elsif register_is_not_required && checkin_is_required
      respond_with :message, text: t(:not_checkin)
    else
      respond_with :message, text: t(:not_registered)
    end
  end
end
