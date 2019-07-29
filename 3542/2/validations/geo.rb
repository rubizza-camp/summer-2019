module Validations
  module Geo
    VALID_LATITUDE = 53.914264..53.916233
    VALID_LONGITUDE = 27.565941..27.571306

    def geo?
      return false unless payload['location']

      valid_latitude? && valid_longitude?
    end

    def valid_latitude?
      VALID_LATITUDE.cover? payload['location']['latitude']
    end

    def valid_longitude?
      VALID_LONGITUDE.cover? payload['location']['longitude']
    end
  end
end
