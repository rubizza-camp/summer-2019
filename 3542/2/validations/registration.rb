module Validations
  module Registration
    def registered?
      chat_session[session_key]
    end
  end
end
