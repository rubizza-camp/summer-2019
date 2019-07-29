module Checkout
  def checkout!
    if session[:checkin]
      update_session_info_checkout
      respond_with :message, text: I18n.t(:face_control)
    else
      respond_with :message, text: I18n.t(:without_checkin)
    end
  end

  def update_session_info_checkout
    save_context :photo
    session[:checkin] = false
    session[:timestamp] = Time.now
    session[:operation] = 'checkout'
  end
end
