module Checkout
  def checkout!(*)
    return say_to_user_chat('not registered for checkin') unless number_registered?

    return say_to_user_chat('already out') unless logged_in?

    say_to_user_chat('send photo')
    save_context(:receive_photo)
  end

  def checkout_accepted
    say_to_user_chat('success checkout')
    session[:timestamp] = Time.now.getutc.to_i
    session[:status] = :out
  end
end
