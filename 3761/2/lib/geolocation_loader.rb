require 'haversine'
require './helper/helper.rb'

class GeolocationLoader
  include Helper

  attr_reader :payload, :time, :status

  CAMP_LOCATION = [53.915451, 27.568789].freeze
  MAX_DISTANCE_FROM_CAMP = 0.2

  def initialize(payload, time, status)
    @payload = payload
    @time = time
    @status = status
  end

  def self.call(payload, time, status)
    new(payload, time, status).call
  end

  def call
    return response_no_geo unless geo_parse

    return response_no_near_camp unless near_camp?

    download_last_geo
    response_successfull
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

  def near_camp?
    Haversine.distance(CAMP_LOCATION, geo_parse.values).to_kilometers < MAX_DISTANCE_FROM_CAMP
  end

  def response_no_geo
    response = 'Are you sure that it is geo??? Try again'
    { status: false, message: response }
  end

  def response_no_near_camp
    response = 'Are you sure tha you\'re near camp. Try again'
    { status: false, message: response }
  end

  def response_successfull
    response = 'Great!!! I believe you=)'
    { status: true, message: response }
  end
end
