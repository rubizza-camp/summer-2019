module SessionState
  private

  def start_not_registered
    respond_with :message, text: needs_checkin if session.key?(:number) && allready_checkouted
    session.key?(:number)
  end

  def allready_registered
    respond_with :message, text: 'Надо зарегистрироваться -> /start' unless session.key?(:number)
    session.key?(:number)
  end

  def allready_checkined
    respond_with :message, text: 'Сначала прими смену -> /checkin' unless session[:checkin]
    session[:checkin]
  end

  def allready_checkouted
    respond_with :message, text: 'Ты принял смену.Можешь её сдать -> /checkout' if session[:checkin]
    !session[:checkin]
  end

  def needs_checkin
    "#{session[:number]}, ты уже зарегистрирован. Можешь принять смену -> /checkin"
  end
end
