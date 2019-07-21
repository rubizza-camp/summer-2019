require './validations/validation'
require './confirmation/confirmation'

module Checkout
  include Validation::Registration
  include Validation::CheckinHelper
  include Validation::Selfie
  include Validation::Geo
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
