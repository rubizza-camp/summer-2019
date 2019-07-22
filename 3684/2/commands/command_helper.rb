module CommandHelper
  API_URL = 'https://api.telegram.org/'.freeze
  TOKEN = ENV['TOKEN']

  def redis
    @redis ||= Redis.new
  end

  def save_data(location, photo_id)
    FileUtils.mkdir_p file_save_path
    save_location(location['latitude'], location['longitude'])
    download_file(photo_id)
  end

  def add_telegram_id
    user_ids = redis.get('telegram_id')
    user_ids = "#{user_ids}, #{from['id']}"
    redis.set('telegram_id', user_ids)
  end

  def respond_to_sucsess_checkin_or_checkout
    case session[:operation]
    when 'checkin'
      respond_with :message, text: 'Можешь приступать'
    when 'checkout'
      respond_with :message, text: 'Можешь отдохнуть'
    end
  end

  private

  def file_save_path
    "public/#{redis.get(from['id'])}/#{session[:operation]}/#{session[:timestamp]}/"
  end

  def save_location(latitude, longitude)
    string = "#{latitude}\n#{longitude}"
    File.open('location.txt', 'w') { |file| file.write(string) }
    FileUtils.mv 'location.txt', file_save_path
  end

  def download_file(file_id)
    uri = URI("#{API_URL}bot#{TOKEN}/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    load_file_from_path(json_response['result']['file_path'])
  end

  def load_file_from_path(file_path)
    uri = URI("#{API_URL}file/bot#{TOKEN}/#{file_path}")
    file_name = "#{SecureRandom.hex(10)}.jpg"
    File.write(file_name, ::Kernel.open(uri).read, mode: 'wb')
    FileUtils.mv file_name, file_save_path
  end
end
