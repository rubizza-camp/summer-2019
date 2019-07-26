module CheckinCommand
  def checkin!
    return respond_with :message, text: NOT_REGISTERED_MESSAGE unless member_is_registered?
    return respond_with :message, text: ALREADY_CHECKINED_MESSAGE unless checkin?

    save_context :make_photo_checkin
    respond_with :message, text: REQUEST_PHOTO_MESSAGE
  end

  def make_photo_checkin(*)
    timestamp
    FileUtils.mkdir_p(file_path_preparation)
    download_photo(file_path_preparation)
    save_context :make_location_checkin
    respond_with :message, text: REQUEST_LOCATION_MESSAGE
  end

  def make_location_checkin
    if valid_location?
      save_location(file_path_preparation)
      checkout
      respond_with :message, text: CHECKIN_SUCCESSFUL_MESSAGE
    else
      respond_with :message, text: LOCATION_ERROR_MESSAGE
    end
  end
end
