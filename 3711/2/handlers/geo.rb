module GeoHandler
  def ask_geo(*)
    respond_with :message, text: 'Now send me your location.'
    save_context :check_geo
  end

  def check_geo(*)
    puts payload
    if geo?
      handle_geo
      change_status
    else
      respond_with :message, text: 'Send me your location, please!'
      save_context :check_geo
    end
  end

  def geo?
    payload.key?('location')
  end

  def handle_geo(*)
    Downloader.load_location(payload['location'], session)
  end

  def change_status
    puts session.inspect
    session[:status] = session[:status] == :in ? :out : :in
    respond_with :message, text: session[:status] == :in ? 'Have a nice day!' : 'See you tomorrow!'
  end
end
