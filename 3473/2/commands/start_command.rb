# frozen_string_literal: true

require './commands/login_command'
require './commands/util'

module StartCommand
  include LoginCommand
  include Util
  def start!(*)
    respond_with :message, text: 'Hello!'
    login! unless registered?
  end
end
