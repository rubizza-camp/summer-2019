module CheckinCommand
  TIME = Time.now.to_s.tr(' ', '_')

  def checkin!(*)
    return check_checkin if Database.redis.exists(from['id'])
    respond_with :message, text: 'You need to register first. Use /start command'
  end

  def check_checkin
    if Database.redis.get(from['id']).include?('in')
      respond_with :message, text: 'You are already checked in'
    else
      respond_with :message, text: 'I need your selfie'
      save_context :check_selfie_in
    end
  end

  def check_selfie_in(*)
    if payload.include?('photo')
      download_photo_in(payload['photo'].last['file_id'])
    else
      respond_with :message, text: 'I need exactly selfie'
      save_context :check_selfie_in
    end
  end

  def download_photo_in(file_id)
    path_for_checkins = "public/#{from['id']}/checkins/#{TIME}"
    FileUtils.mkdir_p path_for_checkins
    File.write("#{path_for_checkins}/selfie.jpg",
               Kernel.open(take_url_for_download_photo_in(file_id)).read,
               mode: 'w')
    respond_with :message, text: 'And your geolocation'
    save_context :check_location_in
  end

  def take_url_for_download_photo_in(file_id)
    url_with_file_path = URI("#{ENV['API']}bot#{ENV['TOKEN']}/getFile?file_id=#{file_id}")
    file_path = JSON.parse(Net::HTTP.get(url_with_file_path))['result']['file_path']
    url_for_download = URI("#{ENV['API']}file/bot#{ENV['TOKEN']}/#{file_path}")
  end

  def check_location_in(*)
    if payload.include?('location')
      download_location_in(payload['location']['latitude'], payload['location']['longitude'])
    else
      respond_with :message, text: 'I need exactly location'
      save_context :check_location_in
    end
  end

  def download_location_in(latitude, longitude)
    path_for_checkins = "public/#{from['id']}/checkins/#{TIME}"
    File.write("#{path_for_checkins}/geo.txt", "#{latitude}, #{longitude}")
    mark_as_checked_in
  end

  def mark_as_checked_in
    mark = Database.redis.get(from['id']).tr('no', 'in')
    Database.redis.set(from['id'], mark)
    respond_with :message, text: 'You are checked in'
  end
end