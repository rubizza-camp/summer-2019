class GeolocationController
  def self.location(bot_webhook)
    call(bot_webhook)
  end

  def self.call(bot_webhook)
    bot_webhook.payload['location']
  rescue NoMethodError
    nil
  end
end
