# frozen_string_literal: true

require_relative '../helpers/validator'

module CheckoutCommand
  include Validator

  def checkout!(*)
    if not_registered? || checked_out?
      handle_checkout_errors
    else
      session[:command] = :checkout
      save_context :ask_for_photo
      respond_with :message, text: 'Send me a photo'
    end
  end

  private

  def handle_checkout_errors
    return register_message if not_registered?

    checkin_message if checked_out?
  end
end
