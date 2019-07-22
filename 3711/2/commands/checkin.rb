# frozen_string_literal: true

require_relative '../authentification'

# top-level module documentation comment
module CheckInCommand
  def checkin!(*)
    if registered?
      respond_with :message, text: 'You are welcome!'
    else
      registrate
    end
  end
end
