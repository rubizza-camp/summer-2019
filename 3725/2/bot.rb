# frozen_string_literal: true

class Bot
  def self.start
    new.start
  end

  def start
    Telegram::Bot::UpdatesPoller.new(client, WebhooksController, logger: logger).start
  end

  private

  def client
    Telegram::Bot::Client.new(token)
  end

  def token
    '812391281:AAGbnwP8CdHvhZV5_rNSw9ryuRRbEUroLno'
  end

  def logger
    Logger.new(STDOUT)
  end
end
