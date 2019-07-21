require './helper/redis_helper.rb'

class GeolocationLoader
  include RedisHelper

  attr_reader :payload, :time, :status

  def initialize(payload, time, status)
    @payload = payload
    @time = time
    @status = status
  end

  def self.call(payload, time, status)
    new(payload, time, status).call
  end

  def call
    response = 'Are you sure that it is geo??? Try again'
    return { status: false, message: response } unless geo_parse

    download_last_geo
    response = 'Great!!! I believe you=)'
    { status: true, message: response }
  end

  private

  def download_last_geo
    File.open(path(status, time) + '/geo.txt', 'wb') do |file|
      file << geo_parse.inspect
    end
  end

  def geo_parse
    @geo_parse = payload['location']
  end
end
