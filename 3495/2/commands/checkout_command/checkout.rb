module CheckoutCommand
  Dotenv.load
  TIME_STAMP = Time.now.strftime('%d/%m/%Y %H:%M').tr('/', '.')
  API_URL = ENV['URL_API'].freeze
  VALID_LATITUDE = 53.914264..53.916233
  VALID_LONGITUDE = 27.565941..27.571306
  def checkout!(*)
    check_sign_up_checkout
  end

  def check_sign_up_checkout
    if !User[from['id']]
      respond_with :message, text: 'Для начала зарегистрируйся'
    else
      check_checkin_checkout
    end
  end

  def check_checkin_checkout
    if !User[from['id']].checkin
      respond_with :message, text: 'Ты ещё не на смене'
    else
      check_type_of_message_on_photo_checkout
    end
  end

  def check_type_of_message_on_photo_checkout
    if payload['photo']
      respond_with :message, text: 'А ты красивый. теперь скинь свои координаты'
      request_file_path_checkout(payload['photo'].last['file_id'])
      save_context :checkout!
    else
      check_type_of_message_on_geo_checkout
    end
  end

  def check_type_of_message_on_geo_checkout
    if payload['location']
      check_geo_checkout
    else
      save_context :checkout!
      respond_with :message, text: 'Покажи личико котик'
    end
  end

  def check_geo_checkout
    if check_location_checkout(payload['location'])
      respond_with :message, text: 'Молодец, свободен'
      load_geo_checkout(payload['location'])
      User[from['id']].update checkin: false
    else
      respond_with :message, text: 'Не ври, ты не в кэмпе'
    end
  end

  def request_file_path_checkout(file_id)
    uri = URI("#{API_URL}bot#{ENV['TOKEN']}/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    load_pic_from_path_checkout(json_response['result']['file_path'])
  end

  def load_geo_checkout(location)
    geo_path = "public/#{from['id']}/checkout/#{TIME_STAMP}/geo.txt"
    File.open(geo_path, 'w')
    File.write(geo_path, location)
  end

  def load_pic_from_path_checkout(file_path)
    uri = URI("#{API_URL}file/bot#{ENV['TOKEN']}/#{file_path}")
    DirCreator.dir_create("public/#{from['id']}/checkout/#{TIME_STAMP}")
    photo_new_path = "public/#{from['id']}/checkout/#{TIME_STAMP}/selfie.jpg"
    File.write(photo_new_path, Kernel.open(uri).read, mode: 'wb')
    photo_new_path
  end

  def check_location_checkout(location)
    VALID_LATITUDE.cover?(location['latitude'].to_f) &&
      VALID_LONGITUDE.cover?(location['longitude'].to_f)
  end
end
