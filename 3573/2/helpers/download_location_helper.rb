module DownloadLocationHelper
  WRITE_GEOLOCATION_FILE = 'geo.txt'.freeze

  def geolocation
    @geolocation ||= payload['location']
  end

  def download_last_geolocation(local_path)
    File.open(local_path + WRITE_GEOLOCATION_FILE, 'w') { |file| file.write(geolocation.inspect) }
  end
end
