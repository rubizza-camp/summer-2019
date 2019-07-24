# frozen_string_literal: true

require './verification.rb'
require './confirmation.rb'

module CommandCheckin
  include Verification::RegistrationProcess
  include Verification::SelfieAttachment
  include Verification::Geolocation
  include Verification::CheckinAssistant
  include Confirmation

  def checkin!(*)
    if register_is_not_required && checkin_is_required
      save_context :selfie_attachment
      respond_with :message, text: t(:selfie)
    elsif register_is_not_required && checkin_is_not_required
      respond_with :message, text: t(:already_checkin)
    else
      respond_with :message, text: t(:not_registered)
    end
  end
end
