# frozen_string_literal: true

require_relative '../authentification'

module StartCommand
  include Authentification

  def start!
    session.delete(:student_id)
    respond_with :message, text: "Hello, #{from['first_name']}!"
    help
    registrate unless registered?
  end

  private

  def help
    respond_with :message, text: 'You can use /checkin and /checkout commands'
  end
end
