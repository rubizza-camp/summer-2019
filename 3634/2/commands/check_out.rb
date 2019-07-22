require 'fileutils'
require_relative 'save_files'

module CheckOutCommand
  LONGITUDE = (53.914264..53.916233).freeze
  LATITUDE = (27.565941..27.571306).freeze

  def checkout!
    save_context(:selfie)
    respond_with(:message, text: 'Send me your selfie, please')
  end

  def selfie(*)
    if selfie?
      session[session_key]['photo'] = payload['photo'].last['file_id']
      save_context(:geoposition)
      respond_with(:message, text: 'Send me your geoposition, please')
    else
      save_context(:selfie)
      respond_with(:message, text: "It doesn't look like selfie. Please, try again")
    end
  end

  def selfie?
    payload['photo']
  end

  def geoposition(*)
    session[session_key]['location'] = payload['location']
    # if geoposition?

    # else
    # end
    SaveFiles.new(session, session_key).save_files
  end

  def geoposition?
    payload['location']
  end
end
