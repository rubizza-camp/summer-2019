module Helpers
  def registered?
    return true if session.key?(:number)
    false
  end

  def checkin?
    return true if session[:checkin?]
    respond_with :message, text: 'You got to checkin first'
    false
  end

  def checkout?
    return true if session[:checkout?]

    false
  end
end
