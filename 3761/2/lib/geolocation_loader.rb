require 'haversine'
Dir[File.join('.', 'helpers', '*.rb')].each { |file| require file }

class GeolocationLoader
  include Helper
  attr_reader :payload, :time, :status

  CAMP_LOCATION = [53.915451, 27.568789].freeze
  MAX_DISTANCE_FROM_CAMP = 0.2
  FOLDER_NAME = '/geo.txt'.freeze

  def initialize(payload, time, status)
    @payload = payload
    @time = time
    @status = status
  end

  def self.call(payload:, time:, status:)
    new(payload, time, status).call
  end

  def call
    raise Errors::NoGeolocationError unless geolocation_from_payload

    raise Errors::FarFromCampError unless near_camp?

    download_last_geolocation
  end

  private

  def download_last_geolocation
    File.open(path(status, time) + FOLDER_NAME, 'wb') do |file|
      file << geolocation_from_payload.inspect
    end
  end

  def geolocation_from_payload
    @geolocation_from_payload ||= payload['location']
  end

  def near_camp?
    current_distance = Haversine.distance(CAMP_LOCATION, geolocation_from_payload.values).to_km
    current_distance < MAX_DISTANCE_FROM_CAMP
  end
end
