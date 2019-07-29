module CheckIn
  require 'telegram/bot'

  def self.start(user)
    return 'The bot is not running. Press /start' if user.state == 'initial'
    return "You can't click /checkin now." if user.state != 'ready_checkin'
    user.state = 'wait_picture'
    'Send me a selfy:'
  end

  def self.save_url_photo(user, message)
    return "You didn't send a selfy" if message.photo.size.zero?
    user.photo = message.photo.last.file_id
    user.state = 'wait_location'
    'Send your location:'
  end

  def self.save_location(user, message, bot)
    location = message.location
    return 'Send your locate:' unless location
    user.location = "latitude: #{location['latitude']}, longitude: #{location['longitude']}"
    create_files(user, bot)
  end

  # :reek:TooManyStatements
  def self.create_files(user, bot)
    folder_path = create_folder_path(user.rubizza_id)
    save_photo(user.photo, folder_path, bot)
    user.photo = nil
    File.open("#{folder_path}geo.txt", 'w') { |file| file.write(user.location) }
    user.location = nil
    user.state = 'ready_checkout'
    'Great, you made a CheckIn'
  end

  def self.create_folder_path(rubizza_id)
    timestamp = Time.now
    folder_path = "public/#{rubizza_id}/checkins/#{timestamp}/"
    FileUtils.mkdir_p folder_path
    folder_path
  end

  # :reek:NestedIterators
  def self.save_photo(photo_id, folder_path, bot)
    file_path = bot.api.get_file(file_id: photo_id).dig('result', 'file_path')
    photo_url = "https://api.telegram.org/file/bot#{TOKEN}/#{file_path}"
    Kernel.open(photo_url) do |image|
      File.open("#{folder_path}selfie.jpg", 'wb') do |file|
        file.write(image.read)
      end
    end
  end
end
