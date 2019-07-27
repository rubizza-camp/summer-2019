module BotCheckinCommands
  def checkin!(*)
    if current_user.in_camp?
      respond_with :message, text: I18n.t(:checkin_error)
    else
      save_context :manage_selfie
      respond_with :message, text: I18n.t(:selfie_request)
    end
  end

  def manage_selfie
    if payload['photo']
      photo_id = payload['photo'].last['file_id']
      PhotoUploader.upload_selfie(current_user.camp_number, photo_id)
      save_context :upload_location
      respond_with :message, text: I18n.t(:location_request)
    else
      respond_with :message, text: I18n.t(:try_again)
    end
  end

  # rubocop:disable Metrics/AbcSize
  def upload_location
    if payload['location']
      GeolocationUploader.create_location_file(current_user.camp_number,
                                               payload['location'])
      current_user.check_in
      respond_with :message, text: I18n.t(:checkin_success)
    else
      respond_with :message, text: I18n.t(:try_again)
    end
  end
  # rubocop:enable Metrics/AbcSize
end
