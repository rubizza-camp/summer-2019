class GeolocationController
  class << self
    def location(bot_webhook)
      call(bot_webhook)
    end

    def call(bot_webhook)
      bot_webhook.payload['location']
    rescue NoMethodError
      nil
    end
  end
end
