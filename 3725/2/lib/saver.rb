module Saver

module FileManager
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
