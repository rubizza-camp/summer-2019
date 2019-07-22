require_relative '../data_check'

module CheckoutCommand
  include DataCheck

  MSG = {
    not_registered: "You got to register first.
    This will be easy, just type in /start command and I'll check your number in list",
    not_checkin: 'You need to /checkin first',
    success: 'Show me yourself first',
    farewell_message: 'I hope you worked well today. Have a nice day',
    farewell_sticker: 'CAADAgADJgADwnaQBi5vOvKDgdd8Ag'
  }.freeze

  def checkout!(*)
    notify(MSG[:not_registered]) && return unless registered?
    notify(MSG[:not_checkin]) && return unless checkin?

    process_checkout
    notify(MSG[:success])
  end

  def checkout_ending
    notify(MSG[:farewell_message])
    send_sticker(MSG[:farewell_sticker])
    set_checkout_flags
  end

  private

  def process_checkout
    session[:command] = 'checkout'
    session[:timestamp] = Time.now.getutc.to_i
    save_context :photo_check
  end

  def set_checkout_flags
    session[:checkin?] = false
    session[:checkout?] = true
  end
end
