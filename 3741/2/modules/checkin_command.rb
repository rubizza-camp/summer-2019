module Checkin
  def checkin!(*)
    return say_to_user_chat('not registered for checkin') unless number_registered?

    return say_to_user_chat('still checkin status') if logged_in?

    say_to_user_chat('send photo!')
    session[:timestamp] = Time.now.getutc.to_i
    save_context(:receive_photo)
  end

  def checkin_accepted
    say_to_user_chat('checkin success')
    session[:status] = :in
  end
end
