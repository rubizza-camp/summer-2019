require 'date'
require_relative 'saver'

module CheckinCommand
  include Saver

  def checkin!(*)
    if session.key?(:number)
      save_context :pic
      respond_with :message, text: 'Send your selfie'
    else
      respond_with :message, text: 'Login first'
    end
  end

  def pic(*context)
    if payload['photo']
      checkin_time
      save_context :geo
      respond_with :message, text: 'Send your geolocation'
    else
      save_context :pic
      respond_with :message, text: 'Wrong data'
    end
  end

  def geo(*context)
    if payload['location']
      take_location(check_in)
      respond_with :message, text: 'Good day to ya'
    else
      save_context :geo
      respond_with :message, text: 'Wrong data'
    end
  end
end
