class LoaderGeoLocation
  include Helper

  VALID_LATITUDE = 53.914264..53.916233
  VALID_LONGITUDE = 27.565941..27.571306

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
    response = 'You must be on work'
    return { status: false, message: response } unless valid?

    { status: true, message: 'U\'re really cool men' }
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
