require_relative 'status.rb'

class PhotoLoader
  attr_reader :token, :options, :status, :response

  def initialize(token, options, status, response)
    @token = token
    @options = options
    @status = status
    @response = response
  end

  # :reek:all
  def call
    case status.current
    when Status::PENDING_CHECKIN_PHOTO
      checkin_photo
    when Status::PENDING_CHECKOUT_PHOTO
      checkout_photo
    else
      response.message('А фотография где?', options)
    end
  end

  def checkin_photo
    download_photo(Status::CHECKIN)
    status.set(Status::PENDING_CHECKIN_GEOLOCATION)
  end

  def checkout_photo
    download_photo(Status::CHECKOUT)
    status.set(Status::PENDING_CHECKOUT_GEOLOCATION)
  end

  # rubocop: disable Metrics/AbcSize
  def download_photo(status)
    file_path = options[:bot].api.get_file(file_id: options[:message].photo[1].file_id)
    uri = 'https://api.telegram.org/file/bot' + token + '/' + file_path['result']['file_path']
    Down.download(uri, destination:
                  "users/#{status}/#{options[:redis]
                  .get('user_id')}/#{options[:redis]
                  .get('timestamp')}/")
    response.message('Теперь геолокация!', options)
  end
  # rubocop: enable Metrics/AbcSize
end
