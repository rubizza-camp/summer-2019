class MessageHelper
  include Answers

  attr_reader :bot, :message

  def initialize(bot, message, user)
    @bot = bot
    @message = message
    @user = user
  end

  def photo?
    !message.photo.empty?
  end

  def location?
    message.location
  end
end
