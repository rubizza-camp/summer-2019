require './validations/validations'
require './confirmation/confirmation'

module Checkin
  include Validations::Registration
  include Validations::CheckinHelper
  include Validations::Selfie
  include Validations::Geo
  include Confirmation

  def checkin!(*)
    if registered? && not_checkin?
      save_context :selfie
      respond_with :message, text: 'Send me selfie, please.'
    elsif registered? && checkin?
      respond_with :message, text: 'You are already checkin.'
    else
      respond_with :message, text: 'You are not registered. Type /start to start registration.'
    end
  end
end
