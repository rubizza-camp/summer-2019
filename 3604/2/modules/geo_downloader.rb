module GeoDownloader
  def download_latest_geo(local_path)
    File.open(local_path + 'geo.txt', 'w') { |file| file.write(geo_parse.inspect) } if geo_parse
  end

  def geo_parse
    @geo_parse ||= payload['location']
  end
end
