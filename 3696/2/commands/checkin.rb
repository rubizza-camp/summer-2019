# frozen_string_literal: true

require_relative '../helpers/base_command_helpers'
require_relative '../helpers/validator'

module CheckinCommand
  include BaseCommandHelpers
  include Validator

  def checkin!(*)
    handle_checkin_errors
    return if checked_in? || not_registered?

    session[:command] = 'checkin'
    save_context :ask_for_photo
    respond_with :message, text: 'Send me a photo'
  end

  private

  def handle_checkin_errors
    checkin_message if not_registered?
    checkout_message if checked_in?
  end
end
