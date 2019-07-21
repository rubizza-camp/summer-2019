def start(bot, message, user)
  if user.resident?
    bot.api.send_message(chat_id: message.chat.id, text: "you're already registered")
  else
    user.action.registration
    user.request.camp_num
    bot.api.send_message(chat_id: message.chat.id, text: 'provide camp num')
  end
end

# ========================

def save_camp_num(bot, message, user)
  if user.action.registration? && user.request.camp_num?
    user.give_residency(message.text)
    user.presence_init
    user.action.flush
    user.request.flush
    bot.api.send_message(chat_id: message.chat.id, text: "#{message.text} you've been registered")
  else
    #send wrong input
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (save_camp_num)')
  end
end

# ========================

def checkin(bot, message, user)
  if user.resident? && !user.present?
    user.action.checkin
    user.request.photo   
    bot.api.send_message(chat_id: message.chat.id, text: 'give me photo')
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (checkin)')
  end
end

def checkout(bot, message, user)
  if user.resident? && user.present?
    user.action.checkout
    user.request.photo    
    bot.api.send_message(chat_id: message.chat.id, text: 'give me photo')
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (checkout)')
  end
end

# =========================

def photo(bot, message, user, token)
  if user.request.photo?
    
    # -prep photo uri
    large_file_id = message.photo.last.file_id
    file = bot.api.get_file(file_id: large_file_id)
    file_path = file.dig('result', 'file_path')
    uri = "https://api.telegram.org/file/bot#{token}/#{file_path}"
    # -

    user.save_photo_uri(uri)
    user.request.location
    bot.api.send_message(chat_id: message.chat.id, text: 'photo received. send location')
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (photo)')
  end  
end

# ======================

def location(bot, message, user)
  if user.request.location?

    # -prep location 
    lat = message.location.latitude.to_s
    long = message.location.longitude.to_s
    # -
    
    user.save_location(lat, long)
    user.presence_switch

    action = user.action.what?
    user.action.flush
    user.request.flush
    bot.api.send_message(chat_id: message.chat.id, text: "#{action} successful")
  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (location)')
  end  
end