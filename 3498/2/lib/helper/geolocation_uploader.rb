class GeolocationUploader
  def self.create_location_file(user_number, latitude, longitude)
    path = "public/#{user_number}/checkins/
            #{Time.now.strftime '%a, %d %b %Y %H:%M'}/geolocation.txt"
    File.open(path, 'wb') do |file|
      file.write "#{latitude}\n"
      file.write longitude
    end
  end
end
