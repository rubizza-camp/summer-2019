require 'date'
require_relative 'saver'

module CheckoutCommand
  include Saver

  def checkout!(*)
    if session.key?(:number)
      save_context :pic_out
      respond_with :message, text: 'Send your selfie'
    else
      respond_with :message, text: 'Login first'
    end
  end

  def pic_out(*context)
    if payload['photo']
      checkout_time
      save_context :geo_out
      respond_with :message, text: 'Send your geolocation'
    else
      save_context :pic_out
      respond_with :message, text: 'Wrong data'
    end
  end

  def geo_out(*context)
    if payload['location']
      take_location(check_out)
      respond_with :message, text: 'Bye!'
    else
      save_context :geo_out
      respond_with :message, text: 'Wrong data'
    end
  end
end
