def start(bot, message, user)
  if user.resident?
    bot.api.send_message(chat_id: message.chat.id, text: "you're already registered")
  else
    user.assign_action_status('register')
    user.assign_request_status('camp_num')
    bot.api.send_message(chat_id: message.chat.id, text: 'provide camp num')
  end
end

def save_camp_num(bot, message, user)
  if user.action_status == 'register' && user.request_status == 'camp_num'
    user.register(message.text)
  else
    #send wrong input
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input')
  end
end