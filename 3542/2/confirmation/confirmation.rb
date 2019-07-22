require './lib/attachment_saver'

module Confirmation
  def selfie(*)
    if selfie?
      chat_session[session_key]['photo'] = payload['photo']

      save_context :geo
      respond_with :message, text: 'Send me your geoposition.'
    else
      save_context :selfie
      respond_with :message, text: "Sorry, it doesn't look like selfie. Try again."
    end
  end

  def geo(*)
    if geo?
      AttachmentSaver.new(chat_session, session_key, payload).save_files

      change_checkin

      respond_with :message, text: 'Success!'
    else
      save_context :geo
      respond_with :message, text: 'It seems, you are not in a camp. Try again.'
    end
  end

  private

  def change_checkin
    chat_session[session_key]['checkin'] = !chat_session[session_key]['checkin']
  end
end
