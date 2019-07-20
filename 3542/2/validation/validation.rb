require './number/number'

module Validation
  module Registration
    def registered?
      chat_session[session_key]
    end
  end

  module Selfie
    def selfie?
      payload['photo']
    end
  end

  module Geo
    def geo?
      return false unless payload['location']

      valid_latitude? && valid_longitude?
    end

    def valid_latitude?
      (53.914264..53.916233).cover? payload['location']['latitude']
    end

    def valid_longitude?
      (27.565941..27.571306).cover? payload['location']['longitude']
    end
  end

  module CheckinHelper
    def checkin?
      chat_session[session_key]['checkin']
    end

    def not_checkin?
      !checkin?
    end
  end
end
