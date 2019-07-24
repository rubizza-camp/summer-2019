require './validations/validations'
require './confirmation/confirmation'

module Checkin
  include Validations::Registration
  include Validations::Helper
  include Validations::Selfie
  include Validations::Geo
  include Confirmation

  def checkin!(*)
    if registered? && not_checkin?
      save_context :selfie
      respond_with :message, text: t(:selfie)
    elsif registered? && checkin?
      respond_with :message, text: t(:already_checkin)
    else
      respond_with :message, text: t(:not_registered)
    end
  end
end
