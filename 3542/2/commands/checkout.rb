require './validations/validations'
require './confirmation/confirmation'

module Checkout
  include Validations::Registration
  include Validations::CheckinHelper
  include Validations::Selfie
  include Validations::Geo
  include Confirmation

  def checkout!(*)
    if registered? && checkin?
      save_context :selfie
      respond_with :message, text: 'Send me selfie, please.'
    elsif registered? && not_checkin?
      respond_with :message, text: 'You are not checkin. Type /checkin to start checkin.'
    else
      respond_with :message, text: 'You are not registered. Type /start to start registration.'
    end
  end
end
