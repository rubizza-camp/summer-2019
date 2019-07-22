class Conversation
  attr_accessor :database
  attr_reader :message, :bot, :chat_id

  def initialize(message:, bot:)
    @message = message
    @bot = bot
    @chat_id = message.chat_id
  end

  def user_said
    message.text
  end

  def status
    database.get(chat_id)
  end

  def change_status(status)
    @database.set(@chat_id.to_s, status)
  end

  def say_to_user(text)
    @bot.api.send_message(chat_id: @chat_id, text: text)
  end

  def help
    say_to_user('/start - to start bot, /checkin - for check in, /checkout - for check out')
  end

  def repeat_please
    say_to_user('Repeat please! try /help to see available commands')
  end
end
