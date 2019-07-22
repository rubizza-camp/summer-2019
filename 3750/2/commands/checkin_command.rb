require_relative '../data_check'

module CheckinCommand
  include DataCheck

  MSG = {
    not_registered: "You got to register first.
    This will be easy, just type in /start command and I'll check your number in list",
    not_checkout: 'You need to /checkout from current shift
    before you can /checkin in a new one',
    success: 'Show me yourself first',
    farewell_message: 'Your shift have successfully begun'
  }.freeze

  def checkin!(*)
    notify(MSG[:not_registered]) && return unless registered?
    notify(MSG[:not_checkout]) && return unless checkout?

    process_checkin
    notify(MSG[:success])
  end

  def checkin_ending
    notify(MSG[:farewell_message])
    set_checkin_flags
  end

  private

  def process_checkin
    session[:command] = 'checkin'
    session[:timestamp] = Time.now.getutc.to_i
    save_context :photo_check
  end

  def set_checkin_flags
    session[:checkin?] = true
    session[:checkout?] = false
  end
end
