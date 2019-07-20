def start(bot, message, user)
  if user.resident?
    bot.api.send_message(chat_id: message.chat.id, text: "you're already registered")
  else
    user.assign_action_status('register')
    user.assign_request_status('camp_num')
    bot.api.send_message(chat_id: message.chat.id, text: 'provide camp num')
  end
end

# ========================

def save_camp_num(bot, message, user)
  if user.action_status == 'register' && user.request_status == 'camp_num'
    user.register(message.text)
    user.assign_presence_status('offsite')
    user.delete_request_status
    user.delete_action_status
    bot.api.send_message(chat_id: message.chat.id, text: "#{message.text} you've been registered")
  else
    #send wrong input
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (save_camp_num)')
  end
end

# ========================

def checkin(bot, message, user)
  if user.resident? && !user.present?
    user.assign_action_status('checkin')
    user.assign_request_status('photo')    
    bot.api.send_message(chat_id: message.chat.id, text: 'give me photo')
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (checkin)')
  end
end

# =========================

def photo(bot, message, user, token)
  if user.request_status == 'photo'

    large_file_id = message.photo.last.file_id
    file = bot.api.get_file(file_id: large_file_id)
    file_path = file.dig('result', 'file_path')
    uri = "https://api.telegram.org/file/bot#{token}/#{file_path}"

    user.store_photo_uri(uri)
    user.assign_request_status('location')   
    bot.api.send_message(chat_id: message.chat.id, text: 'photo received. send location')
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (photo)')
  end  
end