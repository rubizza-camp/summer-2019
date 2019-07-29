module Contexts
  module GeoCheck
    ALLOWED_LATITUDE = 53.914260..53.916240
    ALLOWED_LONGITUDE = 27.565940..27.571310

    def geo_check(*)
      return process_geo_check if valid_location?

      notify(:geo_check_failure)
      save_context(:geo_check)
    end

    private

    def process_geo_check
      Storage.save_location(session, payload)
      checkin_ending if session[:command] == 'checkin'
      checkout_ending if session[:command] == 'checkout'
      session[:command] = nil
    end

    def checkin_ending
      notify(:success_checkin_end)
      session[:checked_in] = true
    end

    def checkout_ending
      notify(:success_checkout_end)
      send_sticker(:farewell_sticker)
      session[:checked_in] = false
    end

    def valid_location?
      return false unless payload['location']
      return false unless allowed_latitude?
      return false unless allowed_longitude?
      true
    end

    def allowed_latitude?
      ALLOWED_LATITUDE.cover? payload['location']['latitude']
    end

    def allowed_longitude?
      ALLOWED_LONGITUDE.cover? payload['location']['longitude']
    end
  end
end
