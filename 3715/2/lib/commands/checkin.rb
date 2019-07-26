module CheckinCommand
  def checkin!
    return respond_with :message, text: I18n.t(:not_registered) unless member_is_registered?
    return respond_with :message, text: I18n.t(:already_checkined) unless checkin?

    save_context :make_photo_checkin
    respond_with :message, text: I18n.t(:request_photo)
  end

  def make_photo_checkin(*)
    timestamp
    FileUtils.mkdir_p(file_path_preparation)
    download_photo(file_path_preparation)
    save_context :make_location_checkin
    respond_with :message, text: I18n.t(:request_location)
  end

  def make_location_checkin
    if valid_location?
      save_location(file_path_preparation)
      checkout
      respond_with :message, text: I18n.t(:checkin_successful)
    else
      respond_with :message, text: I18n.t(:location_error)
    end
  end
end
