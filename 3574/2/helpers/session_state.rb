module SessionStatus
  private

  def start_not_registered
    respond_with :message, text: needs_checkin if session.key?(:number) && allready_checkouted
    session.key?(:number)
  end

  def allready_registered
    respond_with :message, text: 'Сначала регистрация ~> /start' unless session.key?(:number)
    session.key?(:number)
  end

  def allready_checkined
    respond_with :message, text: 'Прими смену ~> /checkin' unless session[:checkin]
    session[:checkin]
  end

  def allready_checkouted
    respond_with :message, text: 'Ты принял смену. Сдашь тут ~> /checkout' if session[:checkin]
    !session[:checkin]
  end

  def needs_checkin
    "#{session[:number]}, прими смену ~> /checkin"
  end
end
