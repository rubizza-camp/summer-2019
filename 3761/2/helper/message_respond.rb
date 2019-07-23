module MessageRespond
  def respond_ask_geo
    { status: true, message: I18n.t(:ask_geo) }
  end

  def respond_no_photo
    { status: false, message: I18n.t(:no_photo) }
  end

  def respond_ask_photo
    respond_with :message, text: I18n.t(:ask_photo)
  end

  def respond_uncheckin
    respond_with :message, text: I18n.t(:checkout_without_checkin)
  end

  def respond_checkout_end
    respond_with :message, text: I18n.t(:checkout_end)
  end

  def respond_uncheckout
    respond_with :message, text: I18n.t(:checkin_without_checkout)
  end

  def respond_unregester
    respond_with :message, text: I18n.t(:need_to_register)
  end

  def respond_checkin_end
    respond_with :message, text: I18n.t(:checkin_end)
  end

  def respond_no_geo
    { status: false, message: I18n.t(:no_geo) }
  end

  def respond_no_near_camp
    { status: false, message: I18n.t(:wrong_geo) }
  end

  def respond_geo_end
    { status: true, message: I18n.t(:geo_end) }
  end

  def response_delete_end
    I18n.t(:delete_end)
  end

  def response_unregester
    I18n.t(:need_to_register)
  end
end
