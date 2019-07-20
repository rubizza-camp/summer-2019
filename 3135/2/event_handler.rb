def start(bot, message, user)
  if user.resident?
    bot.api.send_message(chat_id: message.chat.id, text: "you're already registered")
  else
    user.assign_action_status('register')
    user.assign_request_status('camp_num')
    bot.api.send_message(chat_id: message.chat.id, text: 'provide camp num')
  end
end