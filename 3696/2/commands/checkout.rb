# frozen_string_literal: true

require_relative '../helpers/base_command_helpers'
require_relative '../helpers/validator'

module CheckoutCommand
  include BaseCommandHelpers
  include Validator

  def checkout!(*)
    return if not_registered? || checked_out?

    session[:command] = 'checkout'
    save_context :ask_for_photo
    respond_with :message, text: 'Send me a photo'
  end

  private

  def handle_checkout_errors
    register_message if not_registered?
    checkin_message if checked_out?
  end
end
