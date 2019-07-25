require './modules/user_data_fetcher'
module CheckinCommand
  include UserDataFetcher
  def checkin!(*)
    if session[:checkined]
      respond_with :message, text: 'Смена уже началась(закрыть смену /checkout)'
    elsif session[:registered]
      session[:status] = 'checkin'
      user_data_fetch
    else
      respond_with :message, text: 'Нет доступа(/start)'
    end
  end
end
