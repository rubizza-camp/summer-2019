module Downloader
  class Photo
    PHOTO_URI = 'https://api.telegram.org/bot'.freeze

    private

    def download_user_photo
      token = '812391281:AAGbnwP8CdHvhZV5_rNSw9ryuRRbEUroLno'
      file_path = URI.open(PHOTO_URI + "#{token}/getFile?file_id=#{session[:photo]}").read
      link = JSON.parse(file_path)['result']['file_path']
      URI.open("https://api.telegram.org/file/bot#{token}/#{link}").read
    end
  end

  class File
    def save_data_in_files(session_id)
      path = "./public/#{session_id}/#{session[:type_of_operation]}/#{session[:time_of_operation]}/"
      FileUtils.mkdir_p path
      write_information_in_files(path)
    end

    private

    def write_information_in_files(path)
      File.open(path + 'selfie.jpg', 'wb') { |file| file << download_user_photo }
      File.write(path + 'geo.txt', session[:location].inspect, mode: 'w')
    end
  end
end
