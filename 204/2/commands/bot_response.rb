# :reek:all
class BotResponse
  def message(text, options)
    options[:bot].api.send_message(chat_id: options[:chat_id],
                                   text: text)
  end
end
