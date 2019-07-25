require_relative 'nesting_saver'

module Persuation
  def selfie_attachment(*)
    if selfie?
      chat_session[session_key]['photo'] = payload['photo']

      save_context :geolocation
      respond_with :message, text: 'Let me see you are here. Send me your geolocation'
    else
      save_context :selfie_attachment
      respond_with :message, text: 'I am not a fool. Try again. I need your selfie.'
    end
  end

  def geolocation(*)
    if geo?
      NestingSaver.new(chat_session, session_key, payload).save_files

      change_checkin

      respond_with :message, text: 'Well done! Have a nice day.'
    else
      save_context :geolocation
      respond_with :message, text: 'It seems, you are not in a camp. Try again.'
    end
  end

  private

  def change_checkin
    chat_session[session_key]['checkin'] = !chat_session[session_key]['checkin']
  end
end
