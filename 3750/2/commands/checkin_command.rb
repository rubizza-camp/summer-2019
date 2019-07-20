module CheckinCommand
  def checkin!(*)
    return unless registered?
    save_context :photo_check
    respond_with :message, text: 'Show me yourself first'
  end

  def photo_check(*)
    if !payload['photo'].nil?
      session[:timestamp] = Time.now.getutc.to_i
      path = generate_checkin_path(session[:timestamp])
      FileUtils.mkdir_p(path) unless File.exist?(path)
      save_context :geo_check
      reply_with :message, text: 'You looking pretty good'
      respond_with :message, text: 'Now i need your geolocation'
    else
      save_context :photo_check
      reply_with :message, text: "I don't see a photo here"
      respond_with :message, text: 'Send me something more photogenic'
    end
  end

  def geo_check(*)
    if !payload['location'].nil?
      reply_with :message, text: 'I see you'
      respond_with :message, text: 'Your shift have successfully begun :DDD:'
    else
      save_context :geo_check
      reply_with :message, text: 'That is not location at all'
      respond_with :message, text: 'Show me yourself on map'
    end
  end

  # def photo_file_path
  #   JSON.parse(URI.open(BOT_API_URL + GET_PATH_URL + payload['photo'].last['file_id'])
  #                  .read, symbolize_names: true)[:result][:file_path]
  # end
end