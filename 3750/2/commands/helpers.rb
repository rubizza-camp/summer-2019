module Helpers
  def registered?
    return true if session.key?(:number)
    respond_with :message, text: "Stay still, I don't know who you are!"
    respond_with :message, text: "You got to register first.\n
    This will be easy, just type in /start command and I'll check you number in list"
    false
  end

  def generate_checkin_path(timestamp)
    "./public/#{from['id']}/checkine/#{timestamp}/"
  end

  def generate_checkout_path(timestamp)
    "./public/#{from['id']}/checkouts/#{timestamp}/"
  end
end