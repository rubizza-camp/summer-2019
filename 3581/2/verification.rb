require './numbers_handler.rb'

module Verification
  module RegistrationProcess
    def register_is_not_required
      chat_session[session_key]
    end
  end

  module CheckinAssistant
    def checkin_is_not_required
      chat_session[session_key]['checkin']
    end

    def checkin_is_required
      !checkin_is_not_required
    end
  end

  module SelfieAttachment
    def selfie?
      payload['photo']
    end
  end

  module Geolocation
    NEEDED_LATITUDE = 53.914264..53.916233
    NEEDED_LONGITUDE = 27.565941..27.571306

    def geolocation_data?
      return false unless payload['location']

      needed_longitude
      needed_latitude
    end

    def needed_latitude
      NEEDED_LATITUDE.cover? payload['location']['latitude']
    end

    def needed_longitude
      NEEDED_LONGITUDE.cover? payload['location']['longitude']
    end
  end
end
