class GeolocationUploader
  def self.create_location_file(user_number, location)
    path = "public/#{user_number}/checkins/#{Time.now.strftime '%a, %d %b %Y %H'}/geolocation.txt"
    File.open(path, 'wb') do |file|
      file.write location
    end
  end
end
