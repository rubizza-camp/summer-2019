module CheckinCommand
  TIME_STAMP = Time.now.strftime('%d/%m/%Y %H:%M').tr('/', '.')
  def checkin!(*)
    if !User[from['id']]
      respond_with :message, text: 'Для начала зарегистрируйся'
    elsif User[from['id']].checkin == 'true'
      respond_with :message, text: 'Ты уже на смене'
      return
    elsif payload['photo']
        respond_with :message, text: 'А ты красивый. теперь скинь свои координаты'
        request_file_path(payload['photo'].last['file_id'])
        save_context :checkin!
      elsif payload['location']
        if check_location(payload['location'])
          respond_with :message, text: 'Молодец, порви там всех, за себя и за Оле.. Сашку'
          User[from['id']].update :checkin => 'true'
          load_geo(payload['location'])
        else
          respond_with :message, text: 'Не ври, ты не в кэмпе'
        end
      else
        respond_with :message, text: 'Покажи личико котик'
        save_context :checkin!    
      end      
  end

  def request_file_path(file_id)
    uri = URI("#{API_URL}bot886244897:AAE8balNKJ7Nukdam2v3AuhiAhxCyRysVBs/getFile?file_id=#{file_id}")
    json_response = JSON.parse(Net::HTTP.get(uri))
    load_pic_from_path(json_response['result']['file_path'])
  end

  def load_geo(location)
    geo_path = "public/#{from['id']}/checkin/#{TIME_STAMP}/geo.txt"
    File.open(geo_path, 'w')
    File.write(geo_path, "#{location['latitude'].to_f}, #{location['longitude'].to_f}")
  end

  def load_pic_from_path(file_path)
    uri = URI("#{API_URL}file/bot886244897:AAE8balNKJ7Nukdam2v3AuhiAhxCyRysVBs/#{file_path}")
    DirCreator.dir_create("public/#{from['id']}/checkin/#{TIME_STAMP}")
    photo_new_path = "public/#{from['id']}/checkin/#{TIME_STAMP}/selfie.jpg"
    File.write(photo_new_path, open(uri).read, { mode: 'wb' })
    photo_new_path
  end

  def check_location(location)
    (53.914264.. 53.916233).cover?(location['latitude'].to_f) && (27.565941..27.571306).cover?(location['longitude'].to_f)
  end
  API_URL = 'https://api.telegram.org/'.freeze
end
