require_relative '../registration'

module StartCommand
  include Registration

  MSG = {
    already_registered: 'No need to register again',
    number_request: 'Hello! Tell me your Number'
  }.freeze

  def start!(*)
    notify(MSG[:already_registered]) && return if registered?

    process_registration
    notify(MSG[:number_request])
  end

  private

  def process_registration
    save_context :number_check
  end
end
