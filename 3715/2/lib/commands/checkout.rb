module CheckoutCommand
  def checkout!(*)
    return respond_with :message, text: I18n.t(:not_registered) unless member_is_registered?
    return respond_with :message, text: I18n.t(:already_checkouted) unless checkout?

    save_context :make_photo_checkout
    respond_with :message, text: I18n.t(:request_photo)
  end

  def make_photo_checkout(*)
    timestamp
    FileUtils.mkdir_p(file_path_preparation)
    download_photo(file_path_preparation)
    save_context :make_location_checkout
    respond_with :message, text: I18n.t(:request_location)
  end

  def make_location_checkout
    if valid_location?
      save_location(file_path_preparation)
      checkin
      respond_with :message, text: I18n.t(:checkout_successful)
    else
      respond_with :message, text: I18n.t(:location_error)
    end
  end
end
