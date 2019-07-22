class MessageHelper
  include Answers

  attr_reader :bot, :message

  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def photo?
    !message.photo.empty?
  end

  def location?
    message.location
  end
end
