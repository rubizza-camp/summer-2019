require './lib/attachment_saver'

module Confirmation
  def selfie(*)
    if selfie?
      chat_session[session_key]['photo'] = payload['photo']

      save_context :geo
      respond_with :message, text: t(:geo)
    else
      save_context :selfie
      respond_with :message, text: t(:not_selfie)
    end
  end

  def geo(*)
    if geo?
      AttachmentSaver.new(chat_session, session_key, payload).save_files

      change_checkin

      respond_with :message, text: t(:success)
    else
      save_context :geo
      respond_with :message, text: t(:not_geo)
    end
  end

  private

  def change_checkin
    chat_session[session_key]['checkin'] = !chat_session[session_key]['checkin']
  end
end
