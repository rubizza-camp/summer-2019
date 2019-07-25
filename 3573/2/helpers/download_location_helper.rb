module DownloadLocationHelper
  FILE_GEO = 'geo.txt'.freeze

  def geo_parse
    @geo_parse ||= payload['location']
  end

  def download_last_geo(local_path)
    File.open(local_path + FILE_GEO, 'w') { |file| file.write(geo_parse.inspect) }
  end
end
