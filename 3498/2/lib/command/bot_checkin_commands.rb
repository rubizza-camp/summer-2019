module BotCheckinCommands
  TOKEN = ENV['TG_TOKEN']
  TG_API = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  API_PATH = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze

  def checkin!(*)
    if session[:is_in?]
      respond_with :message, text: 'You have already checked in'
    else
      save_context :manage_selfie
      session[:is_in?] = true
      respond_with :message, text: 'Send me a selfie!'
    end
  end

  private

  def manage_selfie(*)
    upload_selfie
    respond_with :message, text: 'Now send me your location'
    save_context :upload_location
  end

  def upload_selfie(*)
    create_directory
    path = "public/3498/checkins/#{Time.now.strftime('%a, %d %b %Y %H:%M')}/selfie.jpg"
    File.open(path, 'wb') do |file|
      file << URI.open(TG_API + photo_path).read
    end
  end

  def photo_path
    JSON.parse(URI.open(API_PATH + payload['photo'].last['file_id'])
      .read, symbolize_names: true)[:result][:file_path]
  end

  def upload_location(*)
    create_location_file
    respond_with :message, text: 'Cool! Now you are checked in'
  end

  def create_location_file
    path = "public/#{session[:id]}
            /checkins/#{Time.now.strftime '%a, %d %b %Y %H:%M'}/geolocation.txt"
    File.open(path, 'wb') do |file|
      file.write "#{payload['location']['latitude']}\n"
      file.write payload['location']['longitude']
    end
  end

  def create_directory
    path = "public/#{session[:id]}/checkins/#{Time.now.strftime('%a, %d %b %Y %H:%M')}"
    FileUtils.mkdir_p(path)
  end
end
