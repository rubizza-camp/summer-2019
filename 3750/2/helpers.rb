module Helpers
  def registered?
    return true if session.key?(:number)
    respond_with :message, text: "Stay still, I don't know who you are!"
    respond_with :message, text: "You got to register first.\n
    This will be easy, just type in /start command and I'll check your number in list"
    false
  end

  def checkin?
    return true if session[:checkin?]
    respond_with :message, text: 'You got to checkin first'
    false
  end

  def checkout?
    return true if session[:checkout?]
    respond_with :message, text: 'You need to /checkout from current shift
    before you can /checkin in a new one'
    false
  end
end
