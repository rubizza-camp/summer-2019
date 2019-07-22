# frozen_string_literal: true

require_relative '../authentification'

# top-level module documentation comment
module StartCommand
  include Authentification

  def start!(*)
    respond_with :message, text: "Hello, #{from['first_name']}!"
    help
    registrate unless registered?
  end

  private

  def help
    respond_with :message, text: '```here will be help text with list of commands```'
  end
end
