class MessageHelper
  attr_reader :bot, :message
  
  def initialize(bot, message)
    @bot = bot
    @message = message
  end

  def is_a_photo?
    !message.photo.empty?
  end

  def is_location?
    message.location
  end

end