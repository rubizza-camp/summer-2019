require 'fileutils'
require_relative 'save_files'

module EventHandler
  CAMPLATITUDE = (53.913264..53.917233).freeze
  CAMPLONGITUDE = (27.564941..27.572306).freeze

  def event
    save_context :selfie
    respond_with :message, text: 'Send me your selfie, please'
  end

  def selfie(*)
    if selfie?
      chat_session[session_key]['photo'] = payload['photo'].last['file_id']
      input_geo_position
    else
      save_context :selfie
      respond_with :message, text: "It doesn't look like selfie. Please, try again"
    end
  end

  def selfie?
    payload['photo']
  end

  def geoposition(*)
    if geoposition_valid?
      chat_session[session_key]['location'] = payload['location']
      start_save_files
    else
      respond_with :message, text: "It doesn't look you're in camp now! Please, go to camp"
      input_geo_position
    end
  end

  def input_geo_position
    save_context :geoposition
    respond_with :message, text: 'Send me your geoposition, please'
  end

  def geoposition_valid?
    payload['location'] &&
      CAMPLONGITUDE.include?(payload['location']['longitude']) &&
      CAMPLATITUDE.include?(payload['location']['latitude'])
  end

  def start_save_files
    respond_with :message, text: chat_session[session_key]['message']
    status_switcher
    SaveFiles.new(chat_session, session_key).save_files
  end

  def status_switcher
    chat_session[session_key]['status'] = if chat_session[session_key]['status'] == 'in'
                                            'out'
                                          else
                                            'in'
                                          end
    chat_session[session_key]['status'] ||= 'in'
  end
end
