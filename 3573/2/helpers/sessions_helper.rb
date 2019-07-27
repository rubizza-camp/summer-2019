module SessionsHelper
  SESSION_STATUSSES = {
    checkin: 'checkin',
    checkout: 'checkout'
  }.freeze

  def checkin?
    session[:status] == SESSION_STATUSSES[:checkin]
  end

  def checkout?
    session[:status] == SESSION_STATUSSES[:checkout]
  end

  def checkin
    session[:status] = SESSION_STATUSSES[:checkin]
  end

  def checkout
    session[:status] = SESSION_STATUSSES[:checkout]
  end
end
