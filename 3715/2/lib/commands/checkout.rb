module CheckoutCommand
  def checkout!(*)
    return respond_with :message, text: NOT_REGISTERED_MESSAGE unless member_is_registered?
    return respond_with :message, text: ALREADY_CHECKOUTED_MESSAGE unless checkout?

    save_context :make_photo_checkout
    respond_with :message, text: REQUEST_PHOTO_MESSAGE
  end

  def make_photo_checkout(*)
    timestamp
    FileUtils.mkdir_p(file_path_preparation)
    download_photo(file_path_preparation)
    save_context :make_location_checkout
    respond_with :message, text: REQUEST_LOCATION_MESSAGE
  end

  def make_location_checkout
    if valid_location?
      save_location(file_path_preparation)
      checkin
      respond_with :message, text: CHECKOUT_SUCCESSFUL_MESSAGE
    else
      respond_with :message, text: LOCATION_ERROR_MESSAGE
    end
  end
end
