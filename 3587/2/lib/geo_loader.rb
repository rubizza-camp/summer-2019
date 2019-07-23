class LoaderGeoLocation
  include Helper

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
    return { status: false, message: NOT_AT_WORK } unless valid?

    { status: true, message: GREAT }
  end

  private

  def valid?
    valid_latitude? && valid_longitude? && payload['location']
  end

  def valid_latitude?
    VALID_LATITUDE.cover? payload['location']['latitude']
  end

  def valid_longitude?
    VALID_LONGITUDE.cover? payload['location']['longitude']
  end
end
