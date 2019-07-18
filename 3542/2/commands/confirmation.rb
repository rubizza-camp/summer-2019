module Confirmation
  def selfie(*)
    if selfie?
      save_context :geo
      respond_with :message, text: 'Send me your geoposition.'
    else
      save_context :selfie
      respond_with :message, text: "Sorry, it doesn't look like selfie. Try again."
    end
  end

  def geo(*)
    if geo?
      session[session_key]['checkin'] = !session[session_key]['checkin']
      respond_with :message, text: 'Success!'
    else
      save_context :geo
      respond_with :message, text: 'It seems, you are not in a camp. Try again.'
    end
  end
end
