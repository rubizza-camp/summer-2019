# :reek:UtilityFunction
# :reek:FeatureEnvy
# :reek:NestedIterators
# :reek:UtilityFunction
# :reek:TooManyStatements
module ChangeStatusCommand
  def state_wait_picture(user_id, check)
    session_params = load_session_params(user_id)
    return 'The bot is not running. Press /start' unless session_params
    return "you can't click #{check} now. " unless session_params['state'] == 'ready'
    return "you have already done #{check}" if session_params['check'] == check
    session_params['state'] = 'wait_picture'
    session_params['check'] = check
    save_session(user_id, session_params)
    'Send me a selfy:'
  end

  def save_url_photo(message)
    return "You didn't send a selfy" if message.photo.size.zero?
    user_id = message.from.id
    session_params = load_session_params(user_id)
    session_params['state'] = 'wait_locate'
    session_params['photo'] = message.photo.last.file_id
    save_session(user_id, session_params)
    'Send your locate:'
  end

  def check_locate(message)
    location = message.location
    return 'Send your locate:' unless location
    location_text = "latitude: #{location['latitude']}, longitude: #{location['longitude']}"
    ended_change_check_status(message, location_text)
  end

  def ended_change_check_status(message, location_text)
    user_id = message.from.id
    session_params = load_session_params(user_id)
    folder_path = create_folder_path(session_params)
    save_photo(session_params, folder_path)
    session_params.delete('photo')
    save_locate(location_text, folder_path)
    session_params['state'] = 'ready'
    save_session(user_id, session_params)
    "Great, you made a #{session_params['check']}"
  end

  def create_folder_path(session_params)
    rubizza_id = session_params['rubizza_id']
    check = session_params['check']
    timestamp = Time.now
    folder_path = "public/#{rubizza_id}/#{check}s/#{timestamp}/"
    FileUtils.mkdir_p folder_path
    folder_path
  end

  def save_photo(session_params, folder_path)
    photo_id = session_params['photo']
    file_path = @bot.api.get_file(file_id: photo_id).dig('result', 'file_path')
    photo_url = "https://api.telegram.org/file/bot#{TOKEN}/#{file_path}"
    Kernel.open(photo_url) do |image|
      File.open("#{folder_path}selfie.jpg", 'wb') do |file|
        file.write(image.read)
      end
    end
  end

  def save_locate(location, folder_path)
    File.open("#{folder_path}geo.txt", 'w') { |file| file.write(location) }
  end
end
