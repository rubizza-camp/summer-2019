module RecieveUserData
  def recieve_user_photo_in(bot_webhook)
    picture_path = TelegramGetFromApi.photo_from_file_id(@bot_token, bot_webhook)
    if picture_path
      @session_data[:user_in_pic] = picture_path
      @session_course_index += 1
    end
    request_next_operation(bot_webhook)
  end

  def recieve_user_photo_out(bot_webhook)
    picture_path = TelegramGetFromApi.photo_from_file_id(@bot_token, bot_webhook)
    if picture_path
      @session_data[:user_out_pic] = picture_path
      @session_course_index += 1
    end
    request_next_operation(bot_webhook)
  end

  def recieve_user_geo_in(bot_webhook)
    location = GeolocationController.location(bot_webhook)
    if location
      @session_data[:user_in_location] = location
      @session_course_index += 1
    end
    request_next_operation(bot_webhook)
  end

  def recieve_user_geo_out(bot_webhook)
    location = GeolocationController.location(bot_webhook)
    if location
      @session_data[:user_out_location] = location
      @session_course_index += 1
    end
    request_next_operation(bot_webhook)
  end
end
