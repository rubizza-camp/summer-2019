require 'fileutils'

module Save
  private

  def save_data(action)
    make_dir(action)
    save_photo(action)
    save_location(action)
    session[:checkin] = !session[:checkin]
  end

  def make_dir(action)
    session[:timestamp] = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    FileUtils.mkdir_p(path_for(action))
  end

  def save_photo(action)
    File.open(path_for(action) + 'photo.jpg', 'wb') do |file|
      file << photo_for_download.read
    end
  end

  def save_location(action)
    File.open(path_for(action) + 'location.txt', 'wb') do |file|
      file << payload['location']
    end
  end

  def path_for(action)
    "./public/#{session[:number]}/#{action}s/#{session[:timestamp]}/"
  end
end
