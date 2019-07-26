module DownloadLocationHelper
  FILE_GEO = 'geo.txt'.freeze

  def geolocation
    @geolocation ||= payload['location']
  end

  def download_last_geolocation(local_path)
    File.open(local_path + FILE_GEO, 'w') { |file| file.write(geolocation.inspect) }
  end
end
