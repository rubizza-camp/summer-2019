require './modules/user_data_fetcher'
module CheckoutCommand
  include UserDataFetcher
  def checkout!(*)
    if checkined?
      session[:status] = 'checkout'
      user_data_fetch
    elsif !session[:checkined] && session[:registered]
      respond_with :message, text: 'Открой смену (/checkin)'
    else
      respond_with :message, text: 'Нет доступа (/start)'
    end
  end

  private

  def checkined?
    session[:checkined] && session[:registered]
  end
end
