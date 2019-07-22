# frozen_string_literal: true

require_relative './login_command'
require_relative './util'

module StartCommand
  include LoginCommand
  include Util
  def start!(*)
    respond_with :message, text: 'Hello!'
    login! unless registered?
  end
end
