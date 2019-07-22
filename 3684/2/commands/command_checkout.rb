module Checkout
  def checkout!(*)
    if session[:checkin]
      save_context :photo
      update_session_info_checkout
      respond_with :message, text: 'Фейсконтроль'
    else
      respond_with :message, text: 'Ты не чекинился, чудовище -> /checkin'
    end
  end

  def update_session_info_checkout
    session[:checkin] = false
    session[:timestamp] = Time.now
    session[:operation] = 'checkout'
  end
end
