# frozen_string_literal: true

require_relative '../authentification'
require_relative '../handlers/photo'

module CheckOutCommand
  include Authentification
  include PhotoHandler

  def checkout!(*)
    if registered?
      if checkedout?
        respond_with :message, text: "You've already checked out! Fell free :D"
      else
        checkout_context && ask_photo
      end
    else
      registrate
    end
  end

  def checkedout?
    session[:status] == :out
  end

  def checkout_context
    session[:timestamp] = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    session[:command] = :checkout
  end
end
