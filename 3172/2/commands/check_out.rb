module CheckOut
  def self.start(user)
    return 'The bot is not running. Press /start' if user.state == 'initial'
    return "You can't click /checkout now." if user.state != 'ready_checkout'
    user.state = 'ready_checkin'
    'Great, you made a CheckOut'
  end
end
