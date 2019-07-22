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
      respond_with :message, text: t(:selfie)
    elsif registered? && not_checkin?
      respond_with :message, text: t(:not_checkin)
    else
      respond_with :message, text: t(:not_registered)
    end
  end
end
