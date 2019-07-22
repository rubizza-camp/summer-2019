# frozen_string_literal: true

require_relative '../helpers/validator'

module CheckinCommand
  include Validator

  def checkin!(*)
    if checked_in? || not_registered?
      handle_checkin_errors
    else
      session[:command] = :checkin
      save_context :ask_for_photo
      respond_with :message, text: 'Send me a photo'
    end
  end

  private

  def handle_checkin_errors
    return register_message if not_registered?

    checkout_message if checked_in?
  end
end
