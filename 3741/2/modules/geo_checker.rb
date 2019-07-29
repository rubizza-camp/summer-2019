# frozen_string_literal: true

module GeoChecker
  LATITUDE_RANGE = (53.913..53.917).freeze
  LONGITUDE_RANGE = (27.564..27.573).freeze
  def geo_check(*)
    return geo_data_failure unless valid_position?

    geo_save_on_disk
    say_to_user_chat('geo accepted')
    return checkin_accepted unless logged_in?

    checkout_accepted if logged_in?
  end

  def geo_data_failure
    say_to_user_chat('geo data failure,try again')
    save_context(:geo_check)
  end

  def valid_position?
    valid_latitude? && valid_longitude?
  end

  def valid_latitude?
    LATITUDE_RANGE.include?(payload['location']['latitude'])
  end

  def valid_longitude?
    LONGITUDE_RANGE.include?(payload['location']['longitude'])
  end

  def geo_save_on_disk
    File.open(geo_session_path + 'geo.txt', 'wb') do |file|
      file << payload['location'].inspect
    end
  end

  def geo_session_path
    path = PathCreator.save_path(session, payload, TOKEN)
    FileUtils.mkdir_p(path) unless File.exist?(path)
    path
  end
end
