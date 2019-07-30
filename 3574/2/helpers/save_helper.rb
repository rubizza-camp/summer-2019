require 'fileutils'

module SaveHelper
  def save_data(action)
    path = path_for(action)
    make_dir(path)
    save_photo(path)
    save_location(path)
  end

  private

  def make_dir(path)
    session[:timestamp] = Time.now.strftime('%Y-%m-%d_%H-%M-%S')
    FileUtils.mkdir_p(path)
  end

  def save_photo(path)
    File.open("#{path} photo.jpg", 'wb') do |file|
      file << photo_for_download.read
    end
  end

  def save_location(path)
    File.open("#{path} location.txt", 'wb') do |file|
      file << payload['location']
    end
  end

  def path_for(action)
    "./public/#{session[:number]}/#{action}s/#{session[:timestamp]}/"
  end
end
