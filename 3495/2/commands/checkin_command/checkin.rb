module CheckinCommand
  Dotenv.load
  TIME_STAMP = Time.now.strftime('%d/%m/%Y %H:%M').tr('/', '.')
  API_URL = ENV['URL_API'].freeze
  VALID_LATITUDE = 53.914264..53.916233
  VALID_LONGITUDE = 27.565941..27.571306
  def checkin!(*)
    check_sign_up
  end

  def check_sign_up
    if !User[from['id']]
      respond_with :message, text: 'Для начала зарегистрируйся'
    else
      check_checkin
    end
  end

  def check_checkin
    if User[from['id']].checkin
      respond_with :message, text: 'Ты уже на смене'
    else
      check_type_of_message_on_photo
    end
  end

  def check_type_of_message_on_photo
    if payload['photo']
      respond_with :message, text: 'А ты красивый. теперь скинь свои координаты'
      request_file_path(payload['photo'].last['file_id'])
      save_context :checkin!
    else
      check_type_of_message_on_geo
    end
  end

  def check_type_of_message_on_geo
    if payload['location']
      check_geo
    else
      save_context :checkin!
      respond_with :message, text: 'Покажи личико котик'
    end
  end

  def check_geo
    if check_location(payload['location'])
      respond_with :message, text: 'Молодец, порви там всех, за себя и за Оле.. Сашку'
      load_geo(payload['location'])
      User[from['id']].update checkin: true
    else
      respond_with :message, text: 'Не ври, ты не в кэмпе'
    end
  end

  def request_file_path(file_id)
    uri = URI("#{API_URL}bot#{ENV['TOKEN']}/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    load_pic_from_path(json_response['result']['file_path'])
  end

  def load_geo(location)
    geo_path = "public/#{from['id']}/checkin/#{TIME_STAMP}/geo.txt"
    File.open(geo_path, 'w')
    File.write(geo_path, location)
  end

  def load_pic_from_path(file_path)
    uri = URI("#{API_URL}file/bot#{ENV['TOKEN']}/#{file_path}")
    DirCreator.dir_create("public/#{from['id']}/checkin/#{TIME_STAMP}")
    photo_new_path = "public/#{from['id']}/checkin/#{TIME_STAMP}/selfie.jpg"
    File.write(photo_new_path, Kernel.open(uri).read, mode: 'wb')
    photo_new_path
  end

  def check_location(location)
    VALID_LATITUDE.cover?(location['latitude'].to_f) &&
      VALID_LONGITUDE.cover?(location['longitude'].to_f)
  end
end
