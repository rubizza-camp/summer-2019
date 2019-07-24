module DownloadLocation
  def geo_parse
    @geo_parse ||= payload['location']
  end

  def validator_geo
    (53.914264..53.916233).cover?(geo_parse['latitude'].to_f)
  end

  def download_last_geo(local_path)
    File.open(local_path + 'geo.txt', 'w') { |file| file.write(geo_parse.inspect) } if geo_parse
  end
end
