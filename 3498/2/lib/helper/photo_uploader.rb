class PhotoUploader
  TOKEN = ENV['TG_TOKEN']
  TG_API = "https://api.telegram.org/file/bot#{TOKEN}/".freeze
  API_PATH = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id=".freeze

  def self.upload_selfie(user_number, photo_id)
    DirManager.create_directory(user_number, 'checkins')
    path = "public/#{user_number}/checkins/#{Time.now.strftime('%a, %d %b %Y %H')}/selfie.jpg"
    File.open(path, 'wb') do |file|
      file << URI.open(TG_API + photo_path(photo_id)).read
    end
  end

  def self.photo_path(photo_id)
    JSON.parse(URI.open(API_PATH + photo_id)
      .read, symbolize_names: true)[:result][:file_path]
  end
end
