module Validations
  module Geo
    LATITUDE = (53.913835..53.916387).freeze
    LONGITUDE = (27.565138..27.571876).freeze

    def geo?
      return false unless payload['location']

      ok_latitude? && ok_longitude?
    end

    def ok_latitude?
      LATITUDE.cover? payload['location']['latitude']
    end

    def ok_longitude?
      LONGITUDE.cover? payload['location']['longitude']
    end
  end
end
