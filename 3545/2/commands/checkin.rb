# frozen_string_literal: true

module CheckInCommand
  TOKEN = ENV['TOKEN']
  API_URL = "https://api.telegram.org/bot#{TOKEN}/getFile?file_id="
  FILE_API_URL = "https://api.telegram.org/file/bot#{TOKEN}/"

  def checkin!
    if session[:is_checkedin?]
      respond_with :message, text: 'Вы в кемпе'
    elsif session[:id]
      save_context :upload_photo
      session[:is_checkedin?] = true
      respond_with :message, text: 'Пришли мне себяшку'
    else
      respond_with :message, text: 'Зарегистрируйтесь!'
    end
  end

  def upload_photo(*)
    create_checkin_dir

    File.open(checkin_path + '/selfie.jpg', 'wb') do |file|
      file << URI.open(FILE_API_URL + image_path).read
    end

    save_context :upload_geo
    respond_with :message, text: 'Точно пришёл на место?'
  end

  def upload_geo(*)
    File.open(checkin_path + '/geo.txt', 'wb') do |file|
      p payload
      file << payload['location'].to_s
    end
    respond_with :message, text: 'Отлично, порви сегодня всех. За себя и за Сашку.'
  end

  def create_checkin_dir
    FileUtils.mkdir_p(checkin_path) unless File.exist?(checkin_path)
  end

  def checkin_path
    "public/#{chat['id']}/checkins/#{Time.now.strftime('%a, %d %b %Y %H:%M')}"
  end

  def image_path
    JSON.parse(file_response, symbolize_names: true)[:result][:file_path]
  end

  def file_response
    URI.open(API_URL + file_id).read
  end

  def file_id
    payload['photo'].last['file_id']
  end
end
