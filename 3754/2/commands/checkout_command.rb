module CheckoutCommand
  TIME = Time.now.to_s.tr(' ', '_')

  def checkout!(*)
    return check_checkout if Database.redis.exists(from['id'])
    respond_with :message, text: 'You need to register first. Use /start command'
  end

  def check_checkout
    if Database.redis.get(from['id']).include?('no')
      respond_with :message, text: 'You are already checked out'
    else
      respond_with :message, text: 'I need your selfie'
      save_context :check_selfie_out
    end
  end

  def check_selfie_out(*)
    if payload.include?('photo')
      download_photo_out(payload['photo'].last['file_id'])
    else
      respond_with :message, text: 'I need exactly selfie'
      save_context :check_selfie_out
    end
  end

  def download_photo_out(file_id)
    path_for_checkouts = "public/#{from['id']}/checkouts/#{TIME}"
    FileUtils.mkdir_p path_for_checkouts
    File.write("#{path_for_checkouts}/selfie.jpg",
               Kernel.open(take_url_for_download_photo_out(file_id)).read,
               mode: 'w')
    respond_with :message, text: 'And your geolocation'
    save_context :check_location_out
  end

  def take_url_for_download_photo_out(file_id)
    url_with_file_path = URI("#{ENV['API']}bot#{ENV['TOKEN']}/getFile?file_id=#{file_id}")
    file_path = JSON.parse(Net::HTTP.get(url_with_file_path))['result']['file_path']
    url_for_download = URI("#{ENV['API']}file/bot#{ENV['TOKEN']}/#{file_path}")
  end

  def check_location_out(*)
    if payload.include?('location')
      download_location_out(payload['location']['latitude'], payload['location']['longitude'])
    else
      respond_with :message, text: 'I need exactly location'
      save_context :check_location_out
    end
  end

  def download_location_out(latitude, longitude)
    path_for_checkouts = "public/#{from['id']}/checkouts/#{TIME}"
    File.write("#{path_for_checkouts}/geo.txt", "#{latitude}, #{longitude}")
    mark_as_checked_out
  end

  def mark_as_checked_out
    mark = Database.redis.get(from['id']).tr('in', 'no')
    Database.redis.set(from['id'], mark)
    respond_with :message, text: 'You are checked out'
  end
end