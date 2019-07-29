require 'date'
require 'fileutils'
require 'loc'
require './modules/message_fetch'
module UserDataFetcher
  include MessageFetch
  def user_data_fetch
    respond_with :message, text: 'Пришли мне своё фото'
    save_context :photo_check
  end

  # :reek:NilCheck
  def photo_check(*)
    if !payload['photo'].nil?
      photo_download
      save_context :location_check
      respond_with :message, text: 'Пришли мне своё местоположение'
    else
      respond_with :message, text: "Это не фото, попробуй снова(/#{session[:status]})"
    end
  end

  # :reek:NilCheck
  def location_check(*)
    if !payload['location'].nil?
      @location = fetch_location
      where_is_user_check
    else
      respond_with :message, text: "Это не геолокация, попробуй снова(/#{session[:status]})"
    end
  end

  private

  def change_status
    report = session[:checkined] ? 'Смена закончилась' : 'Смена началась'
    session[:checkined] = !session[:checkined]
    respond_with :message, text: report
  end

  def where_is_user_check
    if user_near_work?
      location_download
      change_status
    else
      report = "Ты далеко от работы, будешь рядом - попробуй ещё раз(/#{session[:status]})"
      respond_with :message, text: report
    end
  end

  def photo_download
    @path = "./public/#{session_key}/#{session[:status]}s/#{Date.today.strftime}/"
    FileUtils.mkdir_p @path
    File.write([@path, 'photo.jpg'].join, Net::HTTP.get(fetch_photo_uri))
  end

  def location_download
    @path = "./public/#{session_key}/#{session[:status]}s/#{Date.today.strftime}/"
    File.write([@path, 'location.txt'].join, @location)
  end

  def user_near_work?
    distance <= 500
  end

  def distance
    first_location = Loc::Location[@location[0], @location[1]]
    second_location = Loc::Location[53.915247, 27.569045]
    second_location.distance_to(first_location)
  end
end
