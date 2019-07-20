module Helpers
  TOKEN = '755628942:AAHKAUSeCE6vr3e2ROE-0d_q8UthD8wtrNE'

  def registered?
    return true if session.key?(:number)
    respond_with :message, text: "Stay still, I don't know who you are!"
    respond_with :message, text: "You got to register first.\n
    This will be easy, just type in /start command and I'll check you number in list"
    false
  end

  def generate_checkin_path(timestamp)
    "./public/#{from['id']}/checkins/#{timestamp}/"
  end

  def generate_checkout_path(timestamp)
    "./public/#{from['id']}/checkouts/#{timestamp}/"
  end

  def photo_save
    session[:timestamp] = Time.now.getutc.to_i
    path = generate_checkin_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    telegram_path = JSON.parse(URI.open("https://api.telegram.org/bot#{TOKEN}/" + 'getFile?file_id=' + payload['photo'].last['file_id']).read, symbolize_names: true)[:result][:file_path]
    File.open(path + 'selfie.jpg', 'wb') do |file|
      file << URI.open("https://api.telegram.org/file/bot#{TOKEN}/" + telegram_path).read
    end
  end

  def geo_save
    session[:timestamp] = Time.now.getutc.to_i
    path = generate_checkin_path(session[:timestamp])
    FileUtils.mkdir_p(path) unless File.exist?(path)
    File.open(path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end
end
