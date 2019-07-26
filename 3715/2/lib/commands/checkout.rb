module CheckoutCommand
  def checkout!(*)
    return if not_registered
    return if alredy_checkouted

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
      session.delete('state')
      respond_with :message, text: CHECKOUT_SUCCESSFUL_MESSAGE
    else
      respond_with :message, text: LOCATION_ERROR_MESSAGE
    end
  end
end
