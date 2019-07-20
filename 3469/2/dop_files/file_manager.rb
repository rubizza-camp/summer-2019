module FileManager
  def save_check(session_id)
    path = "./public/#{session_id}/#{session[:type_of_operation]}/#{session[:checkin_time]}/"
    FileUtils.mkdir_p path
    save_information_in_files(path)
  end

  private

  def save_information_in_files(path)
    File.open(path + 'selfie.jpg', 'wb') { |file| file << user_photo }
    File.write(path + 'geo.txt', session[:location].inspect, mode: 'w')
  end
end
