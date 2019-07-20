class MessageHelper
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

  def ask_something
    text = "#{message.from.first_name}, I really don't understand you. May be you wanna /checkin, /checkout or give some info about your location?"
    { chat_id: message.chat.id, text: text }
  end
end
