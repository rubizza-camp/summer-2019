require 'fileutils'

module SaveHelper
  def save_data(action)
    info = path_for(action)
    make_dir(info)
    save_photo(info)
    save_location(info)
  end

  private

  def make_dir(info)
    session[:timestamp] = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    FileUtils.mkdir_p(info)
  end

  def save_photo(info)
    File.open(info + 'photo.jpg', 'wb') do |file|
      file << photo_for_download.read
    end
  end

  def save_location(info)
    File.open(info + 'location.txt', 'wb') do |file|
      file << payload['location']
    end
  end

  def path_for(action)
    "./public/#{session[:number]}/#{action}s/#{session[:timestamp]}/"
  end
end
