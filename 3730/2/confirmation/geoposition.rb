module Geoposition
  LATITUDE = 53.914260..53.916240
  LONGITUDE = 27.565940..27.571310

  def correct_geoposition?
    payload['location'] && correct_latitude? && correct_longitude?
  end

  def save_geoposition(dir_path)
    File.open(dir_path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end

  private

  def correct_latitude?
    LATITUDE.cover? payload['location']['latitude']
  end

  def correct_longitude?
    LONGITUDE.cover? payload['location']['longitude']
  end
end
