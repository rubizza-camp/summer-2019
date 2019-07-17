require 'net/http'
require 'json'
require 'open-uri'
require 'securerandom'
require 'fileutils'

# read user code
module Message
  API_URL = 'https://api.telegram.org/'.freeze
  TEMP_FILES_PATH = 'public/tempData/'.freeze

  def message(text = nil, location = nil)
    redis = Redis.new(host: 'localhost')
    id = from['id']
    txt = payload['text']
    file_id = payload['photo']
    location = payload['location']
    id_s = id.to_s
    check = redis.get(id_s + 'check').to_i
    photo_id = id_s + 'photo'
    get_id = redis.get(id)

    if txt != nil
      text = txt
      if text.length == 4
        file = IO.read('data/codes.yaml')
        if !file.include?(text)
          respond_with :message, text: 'ОШИБКА, такого кода нет'
        else
          if get_id != 12345
            redis.set(id, text)
            respond_with :message, text: 'Регистрация прошла успешно!'
            file.gsub!(text, '')
            respond_with :message, text: 'Что бы принять смену введи /checkin'
            File.open('data/codes.yaml', 'w'){ |files| files.write file }
          end
        end
      end
    end

    file(file_id, photo_id, check)

    time = Time.now.strftime("%Y-%d-%m_%H:%M:%S")
    if location != nil
      if check == 11
        way = "public/#{get_id}/checkin/#{time}"
        locations(location, way, 111)
        respond_with :message, text: 'Не забывай сдать смену коммандой /checkout'
      elsif check == 10
        way = "public/#{get_id}/checkout/#{time}"
        locations(location, way, 0)
        respond_with :message, text: 'Не забывай начать смену коммандой /checkin'
      end
    end


  end

  def load_file_from_path(file_path, photo_id, redis)
    uri = URI("#{API_URL}file/bot#{TOKEN}/#{file_path}")
    photo_new_path = "#{TEMP_FILES_PATH}#{photo_new_path}#{SecureRandom.hex(10)}.jpg"
    FileUtils.mkdir_p(File.dirname(photo_new_path))
    File.write(photo_new_path, ::Kernel.open(uri).read, mode: 'wb')

    redis.set(photo_id, photo_new_path)
  end

  def photo(file_id, num, photo_id)
      redis = Redis.new(host: 'localhost')
      uri = URI("#{API_URL}bot#{TOKEN}/getFile?file_id=#{file_id}")
      json_response = JSON.parse(Net::HTTP.get(uri))
      load_file_from_path(json_response['result']['file_path'], photo_id, redis)
      photo_session(num, redis)
  end

  def photo_session(num, redis)
    check = from['id'].to_s + 'check'
    redis.set(check, num)
  end

  def locations(location, way, num)
    redis = Redis.new(host: 'localhost')
    id = from['id'].to_s
    respond_with :message, text: 'Отлично!'
    redis.set(id + 'check', num)
    save_photo_and_location(location, way, redis)
  end

  def save_photo_and_location(location, way, redis)
    id = from['id'].to_s
    FileUtils.mkdir_p(File.dirname("#{way}/geo.txt"))
    File.open("#{way}/geo.txt", 'w'){|file| file.write location.inspect}
    File.rename redis.get(id + 'photo'), "#{way}/pic.jpg"
  end

  def file(file_id, photo_id, check)
    if file_id != nil
      file_id = file_id.last['file_id']
      respond_with :message, text: 'Точно пришел на место?'

      if check == 1
        photo(file_id, 11, photo_id)
      else
        photo(file_id, 10, photo_id)
      end
    end
  end
end
