# frozen_string_literal: true

require_relative '../authentification'
require_relative '../handlers/photo'

module CheckInCommand
  include Authentification
  include PhotoHandler

  def checkin!(*)
    if registered?
      if checkedin?
        respond_with :message, text: "You've already checked in! Have a nice day :D"
      else
        checkin_context && ask_photo
      end
    else
      registrate
    end
  end

  def checkedin?
    session[:status] == :in
  end

  def checkin_context
    session[:timestamp] = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    session[:command] = :checkin
  end
end
