module DownloadPhoto
  PHOTO_URI = 'https://api.telegram.org/bot'.freeze

  private

  def download_user_photo
    token = ENV['TELEGRAM_TOKEN']
    file_path = URI.open(PHOTO_URI + "#{token}/getFile?file_id=#{session[:photo]}").read
    link = JSON.parse(file_path)['result']['file_path']
    URI.open("https://api.telegram.org/file/bot#{token}/#{link}").read
  end
end
