require_relative './data_keeper.rb'

module Confirmation
  def selfie_attachment(*)
    if selfie?
      chat_session[session_key]['photo'] = payload['photo']

      save_context :geolocation
      respond_with :message, text: t(:geolocation_is)
    else
      save_context :selfie_attachment
      respond_with :message, text: t(:not_selfie)
    end
  end

  def geolocation(*)
    if geolocation_data?
      DataKeeper.new(chat_session, session_key, payload).save_files

      change_checkin

      respond_with :message, text: t(:success)
    else
      save_context :geolocation
      respond_with :message, text: t(:not_geolocation)
    end
  end

  private

  def change_checkin
    chat_session[session_key]['checkin'] = !chat_session[session_key]['checkin']
  end
end
