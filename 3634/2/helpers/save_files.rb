require_relative 'image_loader'

class SaveFiles
  attr_reader :session, :session_key, :payload

  def initialize(session, session_key)
    @session = session
    @session_key = session_key
  end

  def path
    @path ||= "public/#{session_key}/#{Time.now.strftime '%Y-%m-%d_%H:%M:%S'}"
  end

  def save_files
    FileUtils.makedirs(path)
    save :geoposition, path
    save :photo, path
  end

  def save(type, path)
    send(type, path)
  end

  def geoposition(path)
    FileUtils.touch "#{path}/geo.txt"

    File.open(File.expand_path("#{path}/geo.txt"), 'w') do |file|
      file.write "#{session[session_key]['location']['latitude']}\n"
      file.write session[session_key]['location']['longitude']
    end
  end

  def photo(path)
    File.open("#{path}/selfie.jpg", 'wb') do |file|
      file << ImageLoader.new(session, session_key).download_file
    end
  end
end
