module SessionsHelper
  SESSION_STATUSES = {
    checkin: 'checkin',
    checkout: 'checkout'
  }.freeze

  def checkin?
    session[:status] == SESSION_STATUSES[:checkin]
  end

  def checkout?
    session[:status] == SESSION_STATUSES[:checkout]
  end

  def checkin
    session[:status] = SESSION_STATUSES[:checkin]
  end

  def checkout
    session[:status] = SESSION_STATUSES[:checkout]
  end
end
