require_relative 'saver'

module GeopositionCommand
  def geoposition(*)
    if user_location?
      check_confirmation(payload['location'], User[from['id']].person_number, session['status'])
      update_user
    else
      respond_with :message, text: 'I want to see your geoposition'
      save_context :geoposition
    end
  end

  def check_confirmation(location, person_number, folder)
    if UserStates.checkin?(from['id'])
      respond_with :message, text: 'Bye, i wll miss you'
    else
      respond_with :message, text: 'Welcome to camp'
    end
    Saver::FileSaver.save_location(location, person_number, folder)
  end

  private

  def update_user
    UserStates.update_user(from['id'], session['status'])
  end
end
