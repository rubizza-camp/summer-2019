module SessionsHelper
  SESSION_STATUSSES = {
    checkin: 1,
    checkout: 2
  }.freeze

  def checkin?
    session[:status] == 'checkin'
  end

  def checkout?
    session[:status] == 'checkout'
  end

  def checkin
    session[:status] = 'checkin'
  end

  def checkout
    session[:status] = 'checkout'
  end
end
