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

=begin
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

# ======================

def location(bot, message, user)
  if user.request_status == 'location'

    latitude = message.location.latitude
    longitude = message.location.longitude
    user.store_location(latitude, longitude)
    
    action = user.action_status
    if action == 'checkin'
      user.assign_presence_status('onsite')
    else
      user.assign_presence_status('offsite')
    end

    user.delete_request_status
    user.delete_action_status
    bot.api.send_message(chat_id: message.chat.id, text: "#{action} successful")

  else
    bot.api.send_message(chat_id: message.chat.id, text: 'wrong input (location)')
  end  
end
=end