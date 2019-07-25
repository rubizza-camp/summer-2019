module Check
  def checkin!(*)
    if UserStates.checkin?(from['id'])
      respond_with :message, text: 'You already checkin'
    elsif UserStates.already_registered?(from['id'])
      respond_with :message, text: 'Send me a photo'
      session['status'] = 'checkin'
      save_context :user_photo
    else
      respond_with :message, text: 'Register first. Type in /start'
    end
  end

  def checkout!(*)
    if UserStates.already_registered?(from['id']) && UserStates.checkin?(from['id'])
      respond_with :message, text: 'Send me a photo'
      session['status'] = 'checkout'
      save_context :user_photo
    else
      respond_with :message, text: 'Check first. Type in /checkin!'
    end
  end
end
