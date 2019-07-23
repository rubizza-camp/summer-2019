module Validations
  module CheckinHelper
    def checkin?
      chat_session[session_key]['checkin']
    end

    def not_checkin?
      !checkin?
    end
  end
end
