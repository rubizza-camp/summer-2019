require_relative 'status.rb'

class GeolocationFinder
  attr_reader :options, :status, :response

  def initialize(options, status, response)
    @options = options
    @status = status
    @response = response
  end

  RUBIZZA = { latitude: 59, longitude: 30 }.freeze

  # :reek:all
  def call
    case status.current
    when Status::PENDING_CHECKIN_GEOLOCATION
      load_checkin_geo
    when Status::PENDING_CHECKOUT_GEOLOCATION
      load_checkout_geo
    end
  end

  def load_checkin_geo
    if geo_validation
      save_geo_to_file(Status::CHECKIN)
      response.message('Отлично, порви сегодня всех. За себя и за Сашку.', options)
      status.set(Status::REGISTERED)
    else
      response.message('БЕГОМ В КЭМП!', options)
    end
  end

  def load_checkout_geo
    if geo_validation
      save_geo_to_file(Status::CHECKOUT)
      response.message('Ты был молодцом, солдат!', options)
      status.set(Status::FINISH_REGISTRATION)
    else
      response.message('БЕГОМ В КЭМП!', options)
    end
  end

  # rubocop: disable LineLength
  def save_geo_to_file(type)
    File.write("users/#{type}/#{status.get_value('user_id')}/#{status.get_value('timestamp')}/geo.txt", @user_location)
  end
  # rubocop: enable LineLength

  def geo_validation
    @user_location = { latitude: options[:message].location.latitude.to_i,
                       longitude: options[:message].location.longitude.to_i }
    @user_location == RUBIZZA
  end
end
